library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port (
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        PC_Opcode : in  STD_LOGIC_VECTOR(1 downto 0);
        PC_in     : in  STD_LOGIC_VECTOR(15 downto 0);
        PC_out    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal pc_result : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); -- Initialize to 0
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            pc_result <= (others => '0'); -- Reset the counter
        elsif rising_edge(CLK) then
            case PC_Opcode is
                when "00" => 
                    pc_result <= (others => '0'); -- Reset
                when "01" => 
                    pc_result <= std_logic_vector(unsigned(pc_result) + 1); -- Increment
                when "10" => 
                    pc_result <= PC_in; -- Branch
                when "11" => 
                    null; -- No operation (NOP)
                when others => 
                    pc_result <= (others => '0'); -- Default safety
            end case;
        end if;
    end process;

    PC_out <= pc_result;
end Behavioral;
