library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trigger is
end entity tb_trigger;

architecture testbench of tb_trigger is

   constant ClockFrequency : integer := 100e6; -- 100 MHz
   constant ClockPeriod    : time    := 1000 ms / ClockFrequency;
 
   signal Clk   : std_logic := '1';
   signal Rst    : std_logic := '0';
   signal Trig   : std_logic := '0';
   
begin
    
    i_clock_enable: entity work.trigger(Behavioral)
    port map(
        Clk  => Clk,
        Rst  => Rst,
        Trig => Trig);
        
    Clk <= not Clk after ClockPeriod / 2;
    
    process is
    begin    
        Rst <= '1';
        
        wait for 100 ms;
        Rst <= '0';
        wait;
    end process;

end architecture testbench;