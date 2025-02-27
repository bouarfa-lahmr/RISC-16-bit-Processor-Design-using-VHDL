library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder_tb is
end decoder_tb;

architecture Behavioral of decoder_tb is
    -- Component declaration for the Decoder
    component Decoder is
        Port (
            CLK : in STD_LOGIC;
            ENABLE : in STD_LOGIC;
            INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0);
            ALU_OP : out STD_LOGIC_VECTOR (4 downto 0);
            IMM_DATA : out STD_LOGIC_VECTOR (7 downto 0);
            WRITE_ENABLE : out STD_LOGIC;
            SEL_Rm : out STD_LOGIC_VECTOR (2 downto 0);
            SEL_Rn : out STD_LOGIC_VECTOR (2 downto 0);
            SEL_Rd : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals for interfacing with the Decoder
    signal CLK : STD_LOGIC := '0';
    signal ENABLE : STD_LOGIC := '0';
    signal INSTRUCTION : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal ALU_OP : STD_LOGIC_VECTOR(4 downto 0);
    signal IMM_DATA : STD_LOGIC_VECTOR(7 downto 0);
    signal WRITE_ENABLE : STD_LOGIC;
    signal SEL_Rm : STD_LOGIC_VECTOR(2 downto 0);
    signal SEL_Rn : STD_LOGIC_VECTOR(2 downto 0);
    signal SEL_Rd : STD_LOGIC_VECTOR(2 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Decoder
    uut: Decoder
        port map (
            CLK => CLK,
            ENABLE => ENABLE,
            INSTRUCTION => INSTRUCTION,
            ALU_OP => ALU_OP,
            IMM_DATA => IMM_DATA,
            WRITE_ENABLE => WRITE_ENABLE,
            SEL_Rm => SEL_Rm,
            SEL_Rn => SEL_Rn,
            SEL_Rd => SEL_Rd
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

        -- Test 1: Normal operation (Write Enable = '1')
        ENABLE <= '1';
        INSTRUCTION <= "1010110010101010"; -- ALU_OP = "10101", SEL_Rd = "100", SEL_Rm = "101", SEL_Rn = "010", IMM_DATA = "10101010"
        wait for CLK_PERIOD;

        -- Test 2: Branch instruction (Write Enable = '0')
        INSTRUCTION <= "1001100110011001"; -- ALU_OP = "10011", SEL_Rd = "001", SEL_Rm = "100", SEL_Rn = "110", IMM_DATA = "10011001"
        wait for CLK_PERIOD;

        -- Test 3: BEQ instruction (Write Enable = '0')
        INSTRUCTION <= "1010101010101010"; -- ALU_OP = "10101", SEL_Rd = "010", SEL_Rm = "101", SEL_Rn = "010", IMM_DATA = "10101010"
        wait for CLK_PERIOD;

        -- Test 4: STR instruction (Write Enable = '0')
        INSTRUCTION <= "1101111111111111"; -- ALU_OP = "11011", SEL_Rd = "111", SEL_Rm = "111", SEL_Rn = "111", IMM_DATA = "11111111"
        wait for CLK_PERIOD;

        -- Test 5: Disable Decoder (ENABLE = '0')
        ENABLE <= '0';
        INSTRUCTION <= "1111111111111111"; -- No change in outputs
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
