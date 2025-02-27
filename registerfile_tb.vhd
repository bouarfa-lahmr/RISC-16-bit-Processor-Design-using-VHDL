library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity registerfile_tb is
end registerfile_tb;

architecture Behavioral of registerfile_tb is
    -- Component declaration for the RegisterFile
    component RegisterFile is
        Port (
            CLK : in STD_LOGIC;
            ENABLE : in STD_LOGIC;
            WRITE_ENABLE : in STD_LOGIC;
            Rd_DATA : in STD_LOGIC_VECTOR (15 downto 0);
            SEL_Rm : in STD_LOGIC_VECTOR (2 downto 0);
            SEL_Rn : in STD_LOGIC_VECTOR (2 downto 0);
            SEL_Rd : in STD_LOGIC_VECTOR (2 downto 0);
            Rm_out : out STD_LOGIC_VECTOR (15 downto 0);
            Rn_out : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;

    -- Signals for interfacing with the RegisterFile
    signal CLK : STD_LOGIC := '0';
    signal ENABLE : STD_LOGIC := '0';
    signal WRITE_ENABLE : STD_LOGIC := '0';
    signal Rd_DATA : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal SEL_Rm : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal SEL_Rn : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal SEL_Rd : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Rm_out : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_out : STD_LOGIC_VECTOR(15 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the RegisterFile
    uut: RegisterFile
        port map (
            CLK => CLK,
            ENABLE => ENABLE,
            WRITE_ENABLE => WRITE_ENABLE,
            Rd_DATA => Rd_DATA,
            SEL_Rm => SEL_Rm,
            SEL_Rn => SEL_Rn,
            SEL_Rd => SEL_Rd,
            Rm_out => Rm_out,
            Rn_out => Rn_out
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

        -- Test 1: Read from registers (no write)
        ENABLE <= '1';
        WRITE_ENABLE <= '0';
        SEL_Rm <= "001"; -- Select register 1
        SEL_Rn <= "010"; -- Select register 2
        wait for CLK_PERIOD;

        -- Test 2: Write to register and read from it
        WRITE_ENABLE <= '1';
        SEL_Rd <= "001"; -- Write to register 1
        Rd_DATA <= x"1234"; -- Data to write
        wait for CLK_PERIOD;

        -- Test 3: Read from updated register
        WRITE_ENABLE <= '0';
        SEL_Rm <= "001"; -- Select register 1 (updated)
        SEL_Rn <= "010"; -- Select register 2 (unchanged)
        wait for CLK_PERIOD;

        -- Test 4: Write to another register and read from it
        WRITE_ENABLE <= '1';
        SEL_Rd <= "010"; -- Write to register 2
        Rd_DATA <= x"5678"; -- Data to write
        wait for CLK_PERIOD;

        -- Test 5: Read from both updated registers
        WRITE_ENABLE <= '0';
        SEL_Rm <= "001"; -- Select register 1 (updated)
        SEL_Rn <= "010"; -- Select register 2 (updated)
        wait for CLK_PERIOD;

        -- Test 6: Disable RegisterFile (ENABLE = '0')
        ENABLE <= '0';
        SEL_Rm <= "001"; -- Select register 1
        SEL_Rn <= "010"; -- Select register 2
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
