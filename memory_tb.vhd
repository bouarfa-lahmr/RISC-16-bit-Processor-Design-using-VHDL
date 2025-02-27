library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_tb is
end memory_tb;

architecture Behavioral of memory_tb is
    -- Component declaration for the Memory
    component Memory is
        Port (
            CLK         : in  STD_LOGIC;
            RESET       : in  STD_LOGIC;
            ENABLE      : in  STD_LOGIC;
            WRITE_ENABLE: in  STD_LOGIC;
            ADDRESS     : in  STD_LOGIC_VECTOR (15 downto 0);
            DATA_IN     : in  STD_LOGIC_VECTOR (15 downto 0);
            DATA_OUT    : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    -- Signals for interfacing with the Memory
    signal CLK          : STD_LOGIC := '0';
    signal RESET        : STD_LOGIC := '0';
    signal ENABLE       : STD_LOGIC := '0';
    signal WRITE_ENABLE : STD_LOGIC := '0';
    signal ADDRESS      : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal DATA_IN      : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    signal DATA_OUT     : STD_LOGIC_VECTOR (15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Memory
    uut: Memory
        port map (
            CLK => CLK,
            RESET => RESET,
            ENABLE => ENABLE,
            WRITE_ENABLE => WRITE_ENABLE,
            ADDRESS => ADDRESS,
            DATA_IN => DATA_IN,
            DATA_OUT => DATA_OUT
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

        -- Test 1: Reset the Memory
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;

        -- Test 2: Read from Memory (ENABLE = '1', WRITE_ENABLE = '0')
        ENABLE <= '1';
        WRITE_ENABLE <= '0';
        ADDRESS <= "0000000000000000"; -- Address 0
        wait for CLK_PERIOD;

        -- Test 3: Write to Memory (ENABLE = '1', WRITE_ENABLE = '1')
        ENABLE <= '1';
        WRITE_ENABLE <= '1';
        ADDRESS <= "0000000000000100"; -- Address 4
        DATA_IN <= "1111000011110000"; -- Data to write
        wait for CLK_PERIOD;

        -- Test 4: Read from the updated Memory location
        ENABLE <= '1';
        WRITE_ENABLE <= '0';
        ADDRESS <= "0000000000000100"; -- Address 4
        wait for CLK_PERIOD;

        -- Test 5: Disable Memory (ENABLE = '0')
        ENABLE <= '0';
        ADDRESS <= "0000000000000001"; -- Address 1
        wait for CLK_PERIOD;

        -- Test 6: Read from Memory after disabling
        ENABLE <= '1';
        WRITE_ENABLE <= '0';
        ADDRESS <= "0000000000000001"; -- Address 1
        wait for CLK_PERIOD;

        -- Test 7: Write to Memory with invalid address (out of range)
        ENABLE <= '1';
        WRITE_ENABLE <= '1';
        ADDRESS <= "0000000100000000"; -- Address 256 (out of range)
        DATA_IN <= "1010101010101010"; -- Data to write
        wait for CLK_PERIOD;

        -- Test 8: Read from Memory with invalid address (out of range)
        ENABLE <= '1';
        WRITE_ENABLE <= '0';
        ADDRESS <= "0000000100000000"; -- Address 256 (out of range)
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
