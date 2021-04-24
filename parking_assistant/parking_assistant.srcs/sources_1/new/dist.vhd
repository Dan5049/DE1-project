library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations
use ieee.numeric_std.all;   -- Package for arithmetic operations

entity dist is
port(
    clk       : in std_logic;
    rst       : in std_logic;
    echo_i    : in std_logic;
    buzz_o    : inout std_logic;
    leds_o    : out std_logic_vector (10 - 1 downto 0));
end entity dist;

architecture Behavioral of dist is 
    signal s_tick     : integer;
    signal s_dist     : integer;
    signal s_tock     : integer;
    signal s_tock_on  : integer;
    signal s_tock_off : integer;
begin

    p_distance : process(clk, echo_i)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                s_dist <= 10000; -- if dist = 10000 - error value (10m - more than it's able to measure)
                s_tick <= 0;
            else
                if echo_i = '1' then -- if echo is on 1, start counting time
                    s_tick <= s_tick +1; 
                    s_dist <= s_tick /(100*58); 
                else
                    s_tick <= 0;
                end if;
            end if;
        end if;
    end process p_distance;
    
    p_bargraf : process (echo_i, s_dist)
    begin
        if s_dist > 4000 then
            leds_o <= "0000000000";
            s_tock_on <= 0;
            s_tock_off <= 0;
        end if; 
        if falling_edge (echo_i) then
            if (s_dist <= 4000 and s_dist >= 150) then
                leds_o <= "0000000001";
                s_tock_on <= 3000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 150 and s_dist >= 100) then
                leds_o <= "0000000011";
                s_tock_on <= 3500000;
                s_tock_off <= 10000000;
            elsif (s_dist < 100 and s_dist >= 80) then
                leds_o <= "0000000111";
                s_tock_on <= 4000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 80 and s_dist >= 70) then
                leds_o <= "0000001111";
                s_tock_on <= 4500000;
                s_tock_off <= 10000000; 
            elsif (s_dist < 70 and s_dist >= 60) then
                leds_o <= "0000011111";
                s_tock_on <= 5000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 60 and s_dist >= 50) then
                leds_o <= "0000111111";
                s_tock_on <= 6000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 50 and s_dist >= 40) then
                leds_o <= "0001111111";
                s_tock_on <= 7000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 40 and s_dist >= 35) then
                leds_o <= "0011111111";
                s_tock_on <= 8000000;
                s_tock_off <= 10000000;
            elsif (s_dist < 35 and s_dist >= 30) then
                leds_o <= "0111111111";
                s_tock_on <= 9000000;
                s_tock_off <= 10000000;
            elsif s_dist < 30 then
                leds_o <= "1111111111";
                s_tock_on <= 3000000;
                s_tock_off <= s_tock_on + 1;
            else
                leds_o <= "0000000000";
                s_tock_on <= 0;
                s_tock_off <= 0;
            end if;
       end if;    
    end process p_bargraf;
    
    p_buzz : process(clk, s_tock, s_tock_on, s_tock_off, echo_i)is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                buzz_o <= '0';
                s_tock <= 0;
            else
                if rising_edge(echo_i) then
                s_tock <= 0;
                end if;
                
                if (s_tock <= s_tock_on) then
                    buzz_o <= '1';
                    s_tock <= s_tock + 1;
                elsif (s_tock <= s_tock_off and s_tock >= s_tock_on) then
                    buzz_o <= '0';
                    s_tock <= s_tock + 1;
                else 
                    s_tock <= 0;
                end if;
            end if;
        end if;    
    end process p_buzz;
    
end architecture Behavioral;

