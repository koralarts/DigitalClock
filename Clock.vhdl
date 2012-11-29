--------------------------------------
-- Project: DigitalClock 
--
-- File: Clock.vhdl
--
-- Author: Karl Castillo, James Brennan
--
-- Date: November 5, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 26, 2012
-- =============================
-- 
-- Added Clock_clk_o
-- Removed Clock_pulse_o
--
-- Notes:
-------------------------------------

-- Import Libraries --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-----------------
-- 100 MHz Clock
--
-- Notes:
-- Based on the code found in VHDL Guru
-- (http://vhdlguru.blogspot.ca/2010/03/digital-clock-in-vhdl.html)
-----------------
entity Clock is
	port( Clock_clk_i: in  std_logic;
			Clock_clk_o: out std_logic := '1'
		  );
end Clock;

-----------------
-- Behaviour
--
-- Notes:
--
-----------------
architecture Behaviour of Clock is

-- Local Signals
signal sec:		integer range 0 to 60 := 0;
signal count:  integer := 1;
signal clk:		std_logic := '0';

begin
----------------
-- Processes
----------------
-- clk generation. For 100 MHz clock this generates 1 Hz clock.
process(Clock_clk_i)
begin
	if(Clock_clk_i'event and Clock_clk_i = '1') then
		count <= count + 1;
		if(count = 1) then -- 50000000 for release 1 for testing
			clk <= not clk;
			count <= 1;
		end if;
	end if;
end process;

-- period of clk is 1 second
process(clk)
begin
	if(clk'event and clk = '1') then
		sec <= sec + 1;
		if(sec = 59) then
			sec <= 0;
			Clock_clk_o <= '1';
		else
			Clock_clk_o <= '0';
		end if;
	end if;
end process;

end Behaviour;