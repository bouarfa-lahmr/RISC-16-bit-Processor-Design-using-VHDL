library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is
    -- Component declaration for the ALU
    component ALU is
        Port (
            CLK : in STD_LOGIC;
            Enable : in STD_LOGIC;
            ALU_Opcode : in STD_LOGIC_VECTOR (4 downto 0);
            PC_in : in STD_LOGIC_VECTOR (15 downto 0);
            Rm_data : in STD_LOGIC_VECTOR (15 downto 0);
            Rn_data : in STD_LOGIC_VECTOR (15 downto 0);
            Imm_data : in STD_LOGIC_VECTOR (7 downto 0);
            Rd_write_enable_in : in STD_LOGIC;
            Result_out : out STD_LOGIC_VECTOR (15 downto 0);
            Branch_out : out STD_LOGIC;
            Rd_write_enable_out : out STD_LOGIC
        );
    end component;

    -- Signals for interfacing with the ALU
    signal CLK : STD_LOGIC := '0';
    signal Enable : STD_LOGIC := '0';
    signal ALU_Opcode : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal PC_in : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal Rm_data : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal Rn_data : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal Imm_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Rd_write_enable_in : STD_LOGIC := '0';
    signal Result_out : STD_LOGIC_VECTOR(15 downto 0);
    signal Branch_out : STD_LOGIC;
    signal Rd_write_enable_out : STD_LOGIC;

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the ALU
    uut: ALU
        port map (
            CLK => CLK,
            Enable => Enable,
            ALU_Opcode => ALU_Opcode,
            PC_in => PC_in,
            Rm_data => Rm_data,
            Rn_data => Rn_data,
            Imm_data => Imm_data,
            Rd_write_enable_in => Rd_write_enable_in,
            Result_out => Result_out,
            Branch_out => Branch_out,
            Rd_write_enable_out => Rd_write_enable_out
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

        -- Test 1: Add (ALU_Opcode = "00000")
        Enable <= '1';
        ALU_Opcode <= "00000"; -- Add
        Rn_data <= "0000000000000011"; -- 3
        Rm_data <= "0000000000000101"; -- 5
        wait for CLK_PERIOD;

        -- Test 2: Subtract (ALU_Opcode = "00001")
        ALU_Opcode <= "00001"; -- Sub
        Rn_data <= "0000000000000101"; -- 5
        Rm_data <= "0000000000000011"; -- 3
        wait for CLK_PERIOD;

        -- Test 3: OR (ALU_Opcode = "00100")
        ALU_Opcode <= "00100"; -- Or
        Rn_data <= "0000000011110000"; -- 0x00F0
        Rm_data <= "0000000000001111"; -- 0x000F
        wait for CLK_PERIOD;

        -- Test 4: AND (ALU_Opcode = "00011")
        ALU_Opcode <= "00011"; -- And
        Rn_data <= "0000000011110000"; -- 0x00F0
        Rm_data <= "0000000000001111"; -- 0x000F
        wait for CLK_PERIOD;

        -- Test 5: NOT (ALU_Opcode = "00010")
        ALU_Opcode <= "00010"; -- Not
        Rn_data <= "0000000011110000"; -- 0x00F0
        wait for CLK_PERIOD;

        -- Test 6: Compare (ALU_Opcode = "01000")
        ALU_Opcode <= "01000"; -- CMP
        Rn_data <= "0000000000001010"; -- 10
        Rm_data <= "0000000000001010"; -- 10
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
