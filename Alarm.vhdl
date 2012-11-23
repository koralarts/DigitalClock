--------------------------------------
-- Project: DigitalClock
-- 
-- File: Alarm.vhdl
--
-- Author: Karl Castillo
--
-- Date: November 5, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 23, 2012
-- =============================
--
-- Added Alarm_clk_i
-- Added Alarm_set_min_i
-- Added Alarm_set_hur_i
-- Removed Alarm_set_i
-- 
-- Created initial Behaviour
-- Tested Individually
--
-- Notes:
-- The Alarm entity that determines
-- whether or not the current time
-- matches with the alarm time set
-- by the user.
--
-- Status:
-- Individual Testing: Works
-- Testbench Testing: TBD
-------------------------------------

-- Import Libraries --
library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;

-----------------
-- Alarm
-----------------
entity Alarm is
	port(
	    Alarm_clk_i:     in  std_logic; -- Clock
			Alarm_time_i:    in  bit_vector(15 downto 0); -- Current time
			Alarm_set_min_i:	in  integer; -- Set Minute
			Alarm_set_hur_i: in  integer; -- Set Hour
			Alarm_on_i:		    in	 bit; -- Alarm on or off (1 = on, 0 = off)
			Alarm_buzz_o:	   out std_logic -- BUZZ! (1 = buzz, 0 = no buzz)
		  );
	
	-------------
	-- convert
	-- Converts 2 ints to their specific bit_vectors and combines them
	-- into a bit_vector of size 16.
	-------------
  function convert(constant min,hur: in integer) return bit_vector is

	-- Local variables
	variable min_bit: bit_vector(7 downto 0);
	variable hur_bit: bit_vector(7 downto 0);
	variable ret:		bit_vector(15 downto 0);

	begin
		min_bit := to_bitvector(std_logic_vector(to_unsigned(min, 8)));
		hur_bit := to_bitvector(std_logic_vector(to_unsigned(hur, 8)));
		ret(7 downto 0) := min_bit;
		ret(15 downto 8) := hur_bit;
		
		return ret;
	end convert;
end Alarm;

-----------------
-- Behaviour
--
-- Notes:
-- Compares the current time, and set alarm time when Alarm_clk_i and Alarm_on_i 
-- are both '1'
-----------------
architecture Behaviour of Alarm is
  signal bit_alarm: bit_vector(15 downto 0);
begin
  -- Compare Set Alarm time and Current time
  process(Alarm_clk_i)
  begin
    if Alarm_clk_i'event and Alarm_clk_i = '1' and Alarm_on_i = '1' then -- Check if new time, and alarm is on
      bit_alarm <= convert(Alarm_set_min_i, Alarm_set_hur_i); -- Convert to bit vectors
      if bit_alarm = Alarm_time_i then -- Compare if current time equals alarm time
        Alarm_buzz_o <= '1'; -- BUZZ!
      else
        Alarm_buzz_o <= '0'; -- NO BUZZ!
      end if;
    end if;
  end process;
end Behaviour;

