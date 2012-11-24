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
-- =============================
-- November 24, 2012
-- =============================
-- Replaced mm and hh to separate
-- integer to simplify the BCD
-- conversion.
--
-- Replaced the convert function to
-- accomodate single integer input.
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
	function convert(constant m1,m2,h1,h2: in integer) return bit_vector is

	-- Local variables
	variable min_bits: bit_vector(7 downto 0);
	variable hur_bits: bit_vector(7 downto 0);
	variable ret:		bit_vector(15 downto 0);

	begin
	  min_bits(7 downto 4) := to_bitvector(std_logic_vector(to_unsigned(m2, 4)));
		min_bits(3 downto 0) := to_bitvector(std_logic_vector(to_unsigned(m1, 4)));
		hur_bits(7 downto 4) := to_bitvector(std_logic_vector(to_unsigned(h2, 4)));
		hur_bits(3 downto 0) := to_bitvector(std_logic_vector(to_unsigned(h1, 4)));
		ret(7 downto 0) := min_bits;
		ret(15 downto 8) := hur_bits;
		
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
-- minutes
signal m1: integer range 0 to 9 := 0; -- ones
signal m2: integer range 0 to 6 := 0; -- tens
-- hours
signal h1: integer range 0 to 9 := 0; -- ones
signal h2: integer range 0 to 4 := 0; -- tnes

begin
	-- process minute pulses
	process(Controller_minute_i, Controller_set_i)
	begin
		-- check if there's a pulse
		if(Controller_minute_i'event and Controller_minute_i = '1') or
		   (Controller_set_i'event and Controller_set_i = '1') then
			m1 <= m1 + 1;
			if m1 = 9 then
				m2 <= m2 + 1;
				m1 <= 0;
				if m2 = 5 and m1 = 9 then
					h1 <= h1 + 1;
					m1 <= 0;
					m2 <= 0;
					if h1 = 9 then
					  h1 <= 0;
					  h2 <= h2 + 1;
					  if h2 = 2 and h1 = 4 then
					    h2 <= 0;
					  end if;
					end if; -- h1
				end if; -- m2
			end if; -- m1
			
		 Controller_bcd_o <= convert(m1,m2,h1,h2);
		 Controller_alarm_o <= convert(m1,m2,h1,h2);
			
		end if;
	end process;
end Behaviour;

