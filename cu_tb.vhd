library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cu_tb is
end cu_tb;

architecture Behavioral of cu_tb is
    -- Component declaration for the ControlUnit
    component ControlUnit is
        Port (
            CLK : in STD_LOGIC;
            RESET : in STD_LOGIC;
            ALU_OP : in STD_LOGIC_VECTOR (4 downto 0);
            STAGE : out STD_LOGIC_VECTOR (5 downto 0)
        );
    end component;

    -- Signals for interfacing with the ControlUnit
    signal CLK : STD_LOGIC := '0';
    signal RESET : STD_LOGIC := '0';
    signal ALU_OP : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal STAGE : STD_LOGIC_VECTOR(5 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the ControlUnit
    uut: ControlUnit
        port map (
            CLK => CLK,
            RESET => RESET,
            ALU_OP => ALU_OP,
            STAGE => STAGE
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
        -- Apply reset
        RESET <= '1';
        wait for CLK_PERIOD * 2;
        RESET <= '0';

        -- Test normal operation
        ALU_OP <= "00000"; -- Non-LDR/STR operation
        wait for CLK_PERIOD * 6; -- Wait for a full cycle

        -- Test LDR/STR operation
        ALU_OP <= "01100"; -- LDR operation
        wait for CLK_PERIOD * 6; -- Wait for a full cycle

        ALU_OP <= "01101"; -- STR operation
        wait for CLK_PERIOD * 6; -- Wait for a full cycle

        -- End simulation
        wait;
    end process;

end Behavioral;
