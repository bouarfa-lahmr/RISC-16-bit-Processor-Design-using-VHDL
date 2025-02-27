library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
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
end ALU;

architecture Behavioral of ALU is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if Enable = '1' then
                -- Initialize outputs
                Branch_out <= '0';
                Rd_write_enable_out <= '0';

                case ALU_Opcode is
                    when "00000" => -- Add
                        Result_out <= std_logic_vector(unsigned(Rn_data) + unsigned(Rm_data));
                    when "00001" => -- Sub
                        Result_out <= std_logic_vector(unsigned(Rn_data) - unsigned(Rm_data));
                    when "00010" => -- Not
                        Result_out <= not Rn_data;
                    when "00011" => -- And
                        Result_out <= Rn_data and Rm_data;
                    when "00100" => -- Or
                        Result_out <= Rn_data or Rm_data;
                    when "00101" => -- Xor
                        Result_out <= Rn_data xor Rm_data;
                    when "00110" => -- LSL (Logical Shift Left)
                        Result_out <= std_logic_vector(shift_left(unsigned(Rn_data), to_integer(unsigned(Rm_data(3 downto 0)))));
                    when "00111" => -- LSR (Logical Shift Right)
                        Result_out <= std_logic_vector(shift_right(unsigned(Rn_data), to_integer(unsigned(Rm_data(3 downto 0)))));
                    when "01000" => -- CMP (Compare)
                        if Rn_data = Rm_data then
                            Result_out <= (others => '0');
                        else
                            Result_out <= (others => '1');
                        end if;
                    when "01001" => -- B (Branch)
                        Branch_out <= '1';
                        Result_out <= std_logic_vector(unsigned(PC_in) + unsigned(Rm_data));
                    when "01010" => -- BEQ (Branch if Equal)
                        if Rn_data = Rm_data then
                            Branch_out <= '1';
                            Result_out <= std_logic_vector(unsigned(PC_in) + unsigned(Rm_data));
                        else
                            Branch_out <= '0';
                        end if;
                    when "01011" => -- Imm (Immediate)
                        Result_out <= std_logic_vector(resize(unsigned(Imm_data), 16));
                    when "01100" => -- LDR (Load Register)
                        Result_out <= Rm_data; -- Assuming Rm_data holds the value to be loaded
                    when "01101" => -- STR (Store Register)
                        Result_out <= Rn_data; -- Assuming Rn_data holds the value to be stored
                    when others =>
                        Result_out <= (others => '0');
                end case;

                Rd_write_enable_out <= Rd_write_enable_in;
            end if;
        end if;
    end process;
end Behavioral;
