--------------------------------------
-- Project: DigitalClock
--
-- File: Controller.vhdl
--
-- Author: Karl Castillo
--
-- Date: November 5, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 23, 2012
-- =============================
-- Combined the process for set and
-- minute events into the same one.
--
-- Notes:
-------------------------------------

-- Import Libraries --
library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-----------------
-- Controller
--
-- Notes:
-- 
-----------------
entity Controller is
	port( 
			Controller_minute_i: in  std_logic;
			Controller_set_i:		in  std_logic;
			Controller_bcd_o:		out bit_vector(15 downto 0);
			Controller_alarm_o:	out bit_vector(15 downto 0)
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
	
end Controller;

-----------------
-- Behaviour
--
-- Notes:
-- 
-----------------
architecture Behaviour of Controller is

-- Local Signals
signal mm: integer range 0 to 60 := 0;
signal hh: integer range 0 to 24 := 0;

begin
	-- process minute pulses
	process(Controller_minute_i, Controller_set_i)
	begin
		-- check if there's a pulse
		if(Controller_minute_i'event and Controller_minute_i = '1') or
		   (Controller_set_i'event and Controller_set_i = '1') then
			mm <= mm + 1;
			if(mm = 59) then
				mm <= 0;
				hh <= hh + 1;
				if(hh = 24) then
					hh <= 0;
				end if;
			end if;
			
		 Controller_bcd_o <= convert(mm, hh);
		 Controller_alarm_o <= convert(mm, hh);
			
		end if;
	end process;
end Behaviour;

