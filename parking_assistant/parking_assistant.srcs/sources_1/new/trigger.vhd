library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity trigger is
port(
    clk     : in std_logic; --clock
    rst     : in std_logic; --reset
    trig    : out std_logic); --trigger
end entity trigger;

architecture Behavioral of trigger is 
    signal tick     : integer; --time counter, one tick is 10ns
begin

    p_trigger : process(clk)is
    begin
        if rising_edge(clk) then
            if rst = '1' then --if reset is 1, set trigger and time counter to 0
                trig <= '0'; 
                tick <= 0;           
            else
                if (tick <= 1000) then --set trrigger to 1 for time equal to 1000 ticks (10us)
                    trig <= '1';
                    tick <= tick + 1;
                elsif (tick < 10000000 and tick >= 1000) then --set trigger to 0 for the rest of the time of 100ms
                    tick <= tick + 1;
                    trig <= '0';
                else 
                    tick <= 0; --reset time counting
                end if;
           end if;
       end if;
    end process p_trigger;
end architecture Behavioral;
