
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        ENABLE : in STD_LOGIC;
        WRITE_ENABLE : in STD_LOGIC;
        ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
        DATA_IN : in STD_LOGIC_VECTOR (15 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Memory;

architecture Behavioral of Memory is
    type Memory_Array is array (0 to 255) of STD_LOGIC_VECTOR(15 downto 0);
    signal Mem : Memory_Array := (
        0 => "0001000000000001", -- LOAD A
        1 => "0001000000000010", -- LOAD B
        2 => "0010000100000010", -- ADD A, B
        3 => "0011000000000011", -- STORE C
        others => (others => '0') -- Default initialization
    );
begin
    process(CLK, RESET)
    begin
        if RESET = '1' then
            -- Reset memory
            for i in 0 to 255 loop
                Mem(i) <= (others => '0');
            end loop;
        elsif rising_edge(CLK) then
            if ENABLE = '1' then
                if WRITE_ENABLE = '1' then
                    Mem(to_integer(unsigned(ADDRESS))) <= DATA_IN; -- Write
                else
                    DATA_OUT <= Mem(to_integer(unsigned(ADDRESS))); -- Read
                end if;
            end if;
        end if;
    end process;
end Behavioral;
