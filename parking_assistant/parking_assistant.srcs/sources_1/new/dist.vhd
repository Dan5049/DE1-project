library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity dist is
port(
    clk     : in std_logic;
    rst     : in std_logic;
    echo    : in std_logic;
    buzz    : inout std_logic;
    leds    : out std_logic_vector (10 - 1 downto 0));
end entity dist;

architecture Behavioral of dist is 
    signal tick     : integer;
    signal dist     : integer;
    signal tock     : integer;
    signal tock_on  : integer;
    signal tock_off : integer;
begin

    p_distance : process(clk, echo)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                dist <= 10000; -- if dist = 10000 - error value (10m - more than it's able to measure)
                tick <= 0;
            else
                if echo = '1' then -- if echo is on 1, start counting time
                    tick <= tick +1; 
                    dist <= tick /(100*58); 
                else
                    tick <= 0;
                end if;
            end if;
        end if;
    end process p_distance;
    
    p_bargraf : process (echo, dist)
    begin
        if dist > 4000 then
            leds <= "0000000000";
            tock_on <= 0;
            tock_off <= 0;
        end if; 
        if falling_edge (echo) then
            if (dist <= 4000 and dist >= 150) then
                leds <= "0000000001";
                tock_on <= 500000;
                tock_off <= 1000000;
            elsif (dist < 150 and dist >= 100) then
                leds <= "0000000011";
                tock_on <= 50000;
                tock_off <= 100000;
            elsif (dist < 100 and dist >= 80) then
                leds <= "0000000111";
                tock_on <= 5000;
                tock_off <= 10000;
            elsif (dist < 80 and dist >= 70) then
                leds <= "0000001111";
                tock_on <= 500;
                tock_off <= 1000; 
            elsif (dist < 70 and dist >= 60) then
                leds <= "0000011111";
                tock_on <= 50;
                tock_off <= 100;
            elsif (dist < 60 and dist >= 50) then
                leds <= "0000111111";
                tock_on <= 5;
                tock_off <= 10;
            elsif (dist < 50 and dist >= 40) then
                leds <= "0001111111";
                tock_on <= 5;
                tock_off <= 10;
            elsif (dist < 40 and dist >= 35) then
                leds <= "0011111111";
                tock_on <= 5;
                tock_off <= 10;
            elsif (dist < 35 and dist >= 30) then
                leds <= "0111111111";
                tock_on <= 5;
                tock_off <= 10;
            elsif dist < 30 then
                leds <= "1111111111";
                tock_on <= 5;
                tock_off <= 10;
            else
                leds <= "0000000000";
                tock_on <= 0;
                tock_off <= 0;
            end if;
       end if;    
    end process p_bargraf;
    
p_buzz : process(clk, tock, tock_on, tock_off)is
    begin
        if rising_edge(clk) then
            if rst = '1' then 
                buzz        <= '0';
                tock        <= 0;     
            else
                if (tock <= tock_on) then 
                    buzz <= '1';
                    tock <= tock + 1;
                elsif (tock < tock_off and tock >= tock_on) then 
                    tock <= tock + 1;
                    buzz <= '0';
                else 
                    tock <= 0; 
                end if;
           end if;
       end if;
    end process p_buzz;
    
end architecture Behavioral;

