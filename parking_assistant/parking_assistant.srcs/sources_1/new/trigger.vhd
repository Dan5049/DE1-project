library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity trigger is
port(
    Clk     : in std_logic;
    Rst     : in std_logic;
    Trig    : out std_logic);
end entity trigger;

architecture Behavioral of trigger is 
    signal Tick     : integer; 
begin

    process(Clk)is
    begin
        if rising_edge(Clk) then
            if Rst = '1' then
                Trig <= '0'; 
                Tick <= 0;           
            else
                if (Tick < 10000000) then
                    if rising_edge(clk) then
                        Tick <= Tick + 1;
                        if (Tick <= 1000) then
                            Trig <= '1';
                        else
                            Trig <= '0';
                        end if;
                    end if;
                else 
                    Tick <= 0;
                end if;
            end if;
        end if;
    end process;
end architecture Behavioral;
