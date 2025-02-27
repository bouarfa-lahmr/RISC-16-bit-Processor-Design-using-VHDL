
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder is
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
end Decoder;

architecture Behavioral of Decoder is
begin
    process (CLK)
    begin
        if rising_edge (CLK) then
            if ENABLE = '1' then
                ALU_OP <= INSTRUCTION (15 downto 11);
                SEL_Rd <= INSTRUCTION (10 downto 8);
                SEL_Rm <= INSTRUCTION (7 downto 5);
                SEL_Rn <= INSTRUCTION (4 downto 2);
                IMM_DATA <= INSTRUCTION (7 downto 0);

                case INSTRUCTION (14 downto 11) is -- Generate Write signal
                    when "1001" => -- 'B' Branch
                        WRITE_ENABLE <= '0';
                    when "1010" => -- 'BEQ'
                        WRITE_ENABLE <= '0';
                    when "1101" => -- 'STR'
                        WRITE_ENABLE <= '0';
                    when others =>
                        WRITE_ENABLE <= '1';
                end case;
            end if;
        end if;
    end process;
end Behavioral;