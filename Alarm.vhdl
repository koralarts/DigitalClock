--------------------------------------
-- DigitalClock.vhdl
--
-- Author: Karl Castillo
--
-- Date: November 5, 2012
--
-- Revisions: (Date and Description)
--
-- Notes:
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
--
-- Notes:
-- 
-----------------
entity Alarm is
	port( 
			Alarm_minute_i: in std_logic;
			Alarm_alarm_i: in  bit_vector(15 downto 0);
			Alarm_set_i:	in  integer;
			Alarm_on_i:		in	 bit;
			Alarm_buzz_o:	out std_logic
		  );
end Alarm;

-----------------
-- Behaviour
--
-- Notes:
-- 
-----------------
architecture Behaviour of Alarm is

begin
	
end Behaviour;