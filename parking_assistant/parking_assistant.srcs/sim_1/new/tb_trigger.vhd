library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_trigger is
end entity tb_trigger;

architecture testbench of tb_trigger is

   constant clk_freq : integer := 100e6; -- 100 MHz
   constant clk_per    : time    := 1000 ms / clk_freq;
 
   signal clk    : std_logic := '1';
   signal rst    : std_logic := '0';
   signal trig   : std_logic := '0';
   
begin
    
    uut_trigger: entity work.trigger(Behavioral)
    port map(
        clk  => clk,
        rst  => rst,
        trig => trig);
        
    clk <= not clk after clk_per / 2;
    
    process is
    begin    
        rst <= '1';
        
        wait for 100 ms; --first period of trigger (100ms), reset on
        rst <= '0'; --the rest of the time reset off
        wait;
    end process;

end architecture testbench;