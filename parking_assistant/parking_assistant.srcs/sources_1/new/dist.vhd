library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity dist is
port(
    clk     : in std_logic;
    rst     : in std_logic;
    echo    : in std_logic;
    read    : out std_logic);
end entity dist;

architecture Behavioral of dist is 
    signal tick     : integer;
    signal dist     : integer; 
  
begin

    p_distance : process(clk, echo)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                dist <= 10000; -- if dist = 10000 - error value (10m - more than it's able to measure)
                tick <= 0;
                read <= '0';           
            else
                tick <= 0;
                if echo = '1' then -- if echo is on 1, start counting time
                    tick <= tick + 1;
                else 
                    dist <= tick / (100*58); -- calculation from ticks to distance in cm
                end if;
            end if;
        end if;
    end process p_distance;
    
    p_dist_reading : process(dist)
    begin
        if ((dist > 0) and (dist < 10000)) then
            read <= '1';
        else
            read <= '0';
        end if; 
    end process p_dist_reading;
    
end architecture Behavioral;
