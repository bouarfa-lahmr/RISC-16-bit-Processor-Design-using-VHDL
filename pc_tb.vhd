library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is
    -- Component declaration for the PC
    component PC is
        Port (
            CLK       : in  STD_LOGIC;
            RESET     : in  STD_LOGIC;
            PC_Opcode : in  STD_LOGIC_VECTOR(1 downto 0);
            PC_in     : in  STD_LOGIC_VECTOR(15 downto 0);
            PC_out    : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    -- Signals for interfacing with the PC
    signal CLK       : STD_LOGIC := '0';
    signal RESET     : STD_LOGIC := '0';
    signal PC_Opcode : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal PC_in     : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal PC_out    : STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the PC
    uut: PC
        port map (
            CLK => CLK,
            RESET => RESET,
            PC_Opcode => PC_Opcode,
            PC_in => PC_in,
            PC_out => PC_out
        );

    -- Clock generation process
    CLK_PROCESS: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    STIM_PROCESS: process
    begin
        -- Wait for initial reset
        wait for CLK_PERIOD;

        -- Test 1: Reset the PC
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;

        -- Test 2: Increment the PC
        PC_Opcode <= "01"; -- Increment
        wait for CLK_PERIOD; -- Increment once
        wait for CLK_PERIOD; -- Increment twice
        wait for CLK_PERIOD; -- Increment three times

        -- Test 3: Branch to a new address
        PC_Opcode <= "10"; -- Branch
        PC_in <= "0000000011111111"; -- New address (binary for x"00FF")
        wait for CLK_PERIOD;

        -- Test 4: No operation (NOP)
        PC_Opcode <= "11"; -- NOP
        wait for CLK_PERIOD;

        -- Test 5: Reset the PC again
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;

        -- Test 6: Invalid Opcode (default behavior)
        PC_Opcode <= "00"; -- Invalid opcode (treated as reset)
        wait for CLK_PERIOD;

        -- Test 7: Reset and Increment
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        PC_Opcode <= "01"; -- Increment
        wait for CLK_PERIOD;

        -- Test 8: Branch after Increment
        PC_Opcode <= "10"; -- Branch
        PC_in <= "0000000000001010"; -- New address (binary for x"000A")
        wait for CLK_PERIOD;

        -- Test 9: NOP after Branch
        PC_Opcode <= "11"; -- NOP
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
