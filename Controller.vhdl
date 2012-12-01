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
-- =============================
-- November 26, 2012
-- =============================
--
-- Added Controller_clk_i
-- Added Controller_time_o
-- Removed Controller_pulse_i
-- Removed Controller_alarm_o
-- Removed Controller_bcd_o
-- Removed convert function
--
-- Simplified the output (time) and
-- combined it into one signal.
-- Both the Alarm and BCD will take
-- in Controller_time_o as intput.
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
	port( Controller_clk_i:  in  std_logic;
			Controller_set_i:	 in  std_logic;
			Controller_time_o: out bit_vector(15 downto 0)
		  );
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
signal m1: integer range 0 to 10 := 0; -- ones
signal m2: integer range 0 to 6 := 0; -- tens
-- hours
signal h1: integer range 0 to 10 := 0; -- ones
signal h2: integer range 0 to 3 := 0; -- tnes

begin
	-- process minute pulses
	process(Controller_clk_i, Controller_set_i)
	begin
		-- check if there's a pulse
		if Controller_clk_i = '1' or Controller_set_i = '1' then
		    m1 <= m1 + 1;
			Controller_time_o(3 downto 0) <= to_bitvector(std_logic_vector(to_unsigned(m1, 4)));
			if m1 = 9 then
				m2 <= m2 + 1;
				m1 <= 0;
				Controller_time_o(7 downto 4) <= to_bitvector(std_logic_vector(to_unsigned(m2, 4)));
				if m2 = 5 and m1 = 9 then
					h1 <= h1 + 1;
					m1 <= 0;
					m2 <= 0;
					Controller_time_o(11 downto 8) <= to_bitvector(std_logic_vector(to_unsigned(h1, 4)));
					if h1 = 9 then
					  h2 <= h2 + 1;
					  h1 <= 0;
					  Controller_time_o(15 downto 12)<= to_bitvector(std_logic_vector(to_unsigned(h2, 4)));
					  
					end if; -- h1
					if h2 = 2 and h1 = 4 then
						 h2 <= 0;
						 h1 <= 0;
					  end if;
				end if; -- m2
			end if; -- m1
		end if; 
	end process;
end Behaviour;