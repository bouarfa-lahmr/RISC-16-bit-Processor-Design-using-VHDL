library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CPU is
    Port (
        INSTRUCTION  : in  STD_LOGIC_VECTOR(15 downto 0);
        CLK          : in  STD_LOGIC;
        RST          : in  STD_LOGIC;
        ADDRESS      : out STD_LOGIC_VECTOR(15 downto 0);
        RAM_ENABLE   : out STD_LOGIC;
        RAM_WRITE    : out STD_LOGIC;
        RAM_DATA     : inout STD_LOGIC_VECTOR(15 downto 0)
    );
end CPU;

architecture Behavioral of CPU is
    -- Internal signals
    signal pc_address       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal alu_result       : STD_LOGIC_VECTOR(15 downto 0);
    signal alu_branch       : STD_LOGIC;
    signal reg_write_enable : STD_LOGIC;
    signal imm_data         : STD_LOGIC_VECTOR(7 downto 0);
    signal alu_opcode       : STD_LOGIC_VECTOR(4 downto 0);
    signal sel_rm, sel_rn, sel_rd : STD_LOGIC_VECTOR(2 downto 0);
    signal rm_data, rn_data : STD_LOGIC_VECTOR(15 downto 0);
    signal ram_write_data   : STD_LOGIC_VECTOR(15 downto 0);
    signal ram_read_data    : STD_LOGIC_VECTOR(15 downto 0);

    -- Internal signals for RAM_ENABLE and RAM_WRITE
    signal ram_enable_internal : STD_LOGIC;
    signal ram_write_internal  : STD_LOGIC;

begin
    -- Output connections
    ADDRESS       <= pc_address;
    RAM_ENABLE    <= ram_enable_internal; -- Internal signal drives the output
    RAM_WRITE     <= ram_write_internal;  -- Internal signal drives the output

    -- Bidirectional RAM data
    RAM_DATA <= ram_write_data when ram_write_internal = '1' else (others => 'Z');
    ram_read_data <= RAM_DATA;

    -- Set internal RAM signals
    ram_enable_internal <= '1'; -- Always active for simplicity; refine as needed
    ram_write_internal  <= reg_write_enable;

    -- PC Instance
    PC_instance : entity work.PC
        Port map (
            CLK       => CLK,
            RESET     => RST,
            PC_Opcode => "01", -- Example: Increment opcode
            PC_in     => alu_result,
            PC_out    => pc_address
        );

    -- ALU Instance
    ALU_instance : entity work.ALU
        Port map (
            CLK                => CLK,
            Enable             => '1', -- Enable ALU operations
            ALU_Opcode         => alu_opcode,
            PC_in              => pc_address,
            Rm_data            => rm_data,
            Rn_data            => rn_data,
            Imm_data           => imm_data,
            Rd_write_enable_in => reg_write_enable,
            Result_out         => alu_result,
            Branch_out         => alu_branch,
            Rd_write_enable_out=> reg_write_enable
        );

    -- Decoder Instance
    Decoder_instance : entity work.Decoder
        Port map (
            CLK          => CLK,
            ENABLE       => '1', -- Decoder always active
            INSTRUCTION  => INSTRUCTION,
            ALU_OP       => alu_opcode,
            IMM_DATA     => imm_data,
            WRITE_ENABLE => reg_write_enable,
            SEL_Rm       => sel_rm,
            SEL_Rn       => sel_rn,
            SEL_Rd       => sel_rd
        );

    -- Register File Instance
    RegisterFile_instance : entity work.RegisterFile
        Port map (
            CLK          => CLK,
            ENABLE       => '1', -- Always active
            WRITE_ENABLE => reg_write_enable,
            Rd_DATA      => alu_result,
            SEL_Rm       => sel_rm,
            SEL_Rn       => sel_rn,
            SEL_Rd       => sel_rd,
            Rm_out       => rm_data,
            Rn_out       => rn_data
        );

    -- Memory Instance
    Memory_instance : entity work.Memory
        Port map (
            CLK          => CLK,
            RESET        => RST,
            ENABLE       => ram_enable_internal, -- Use internal signal
            WRITE_ENABLE => ram_write_internal,  -- Use internal signal
            ADDRESS      => pc_address,
            DATA_IN      => ram_write_data,
            DATA_OUT     => ram_read_data
        );

end Behavioral;
