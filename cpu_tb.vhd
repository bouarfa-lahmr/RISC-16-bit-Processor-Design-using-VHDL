library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is
    -- Component declaration for the CPU
    component CPU is
        Port (
            INSTRUCTION  : in  STD_LOGIC_VECTOR(15 downto 0);
            CLK          : in  STD_LOGIC;
            RST          : in  STD_LOGIC;
            ADDRESS      : out STD_LOGIC_VECTOR(15 downto 0);
            RAM_ENABLE   : out STD_LOGIC;
            RAM_WRITE    : out STD_LOGIC;
            RAM_DATA     : inout STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    -- Signals for interfacing with the CPU
    signal CLK          : STD_LOGIC := '0';
    signal RST          : STD_LOGIC := '0';
    signal INSTRUCTION  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal ADDRESS      : STD_LOGIC_VECTOR(15 downto 0);
    signal RAM_ENABLE   : STD_LOGIC;
    signal RAM_WRITE    : STD_LOGIC;
    signal RAM_DATA     : STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

    -- Memory initialization
    type Memory_Array is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
    signal Mem : Memory_Array := (
        -- Program 1: Load A, Load B, Add A and B, Store C
        0 => "0001000000000001", -- LOAD A (Opcode: 0001, Rd: 000, Imm: 00000001)
        1 => "0001000100000010", -- LOAD B (Opcode: 0001, Rd: 001, Imm: 00000010)
        2 => "0010000000000001", -- ADD A, B (Opcode: 0010, Rd: 000, Rm: 001)
        3 => "0011001000000011", -- STORE C (Opcode: 0011, Rd: 010, Imm: 00000011)

        -- Program 2: Load X, Load Y, AND X and Y, Store Result
        4 => "0001001100000100", -- LOAD X (Opcode: 0001, Rd: 011, Imm: 00000100)
        5 => "0001010000000101", -- LOAD Y (Opcode: 0001, Rd: 100, Imm: 00000101)
        6 => "0001101100000100", -- AND X, Y (Opcode: 0001, Rd: 011, Rm: 100)
        7 => "0011010100000110", -- STORE Result (Opcode: 0011, Rd: 101, Imm: 00000110)

        others => (others => '0') -- Default initialization
    );

begin
    -- Instantiate the CPU
    uut: CPU
        port map (
            INSTRUCTION => INSTRUCTION,
            CLK => CLK,
            RST => RST,
            ADDRESS => ADDRESS,
            RAM_ENABLE => RAM_ENABLE,
            RAM_WRITE => RAM_WRITE,
            RAM_DATA => RAM_DATA
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

        -- Reset the CPU
        RST <= '1';
        wait for CLK_PERIOD;
        RST <= '0';
        wait for CLK_PERIOD;

        -- Execute Program 1: Load A, Load B, Add A and B, Store C
        for i in 0 to 3 loop
            INSTRUCTION <= Mem(i); -- Fetch instruction from memory
            wait for CLK_PERIOD;
        end loop;

        -- Wait for Program 1 to complete
        wait for CLK_PERIOD * 4;

        -- Execute Program 2: Load X, Load Y, AND X and Y, Store Result
        for i in 4 to 7 loop
            INSTRUCTION <= Mem(i); -- Fetch instruction from memory
            wait for CLK_PERIOD;
        end loop;

        -- Wait for Program 2 to complete
        wait for CLK_PERIOD * 4;

        -- End simulation
        wait;
    end process;

end Behavioral;
