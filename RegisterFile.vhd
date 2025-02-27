
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
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
end RegisterFile;

architecture Behavioral of RegisterFile is
    type register_array is array (0 to 7) of STD_LOGIC_VECTOR (15 downto 0);
    signal reg_file: register_array := (others => (others => '0'));
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if ENABLE = '1' then
                -- Read register values
                Rm_out <= reg_file(to_integer(unsigned(SEL_Rm)));
                Rn_out <= reg_file(to_integer(unsigned(SEL_Rn)));

                -- Write to register
                if WRITE_ENABLE = '1' then
                    reg_file(to_integer(unsigned(SEL_Rd))) <= Rd_DATA;
                end if;
            end if;
        end if;
    end process;
end Behavioral;