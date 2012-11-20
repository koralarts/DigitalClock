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
	
	-- Functions
	-----------------
	-- Convert
	--
	-- Notes:
	-- 
	-----------------
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
	process(Controller_minute_i)
	begin
		-- check if there's a pulse
		if(Controller_minute_i'event and Controller_minute_i = '1') then
			mm <= mm + 1;
			if(mm = 59) then
				mm <= 0;
				hh <= hh + 1;
				if(hh = 24) then
					hh <= 0;
				end if;
			end if;
			
			-- convert to bit_vector for transfer
			Controller_bcd_o <= convert(mm, hh);
			Controller_alarm_o <= convert(mm, hh);
			
		end if;
	end process;
	
	-- process set pulses
	process(Controller_set_i)
	begin
		if(Controller_set_i'event and Controller_set_i = '1') then
			mm <= mm + 1;
			if(mm = 59) then
				mm <= 0;
				hh <= hh + 1;
				if(hh = 24) then
					hh <= 0;
				end if;
			end if;
			
			-- convert to bit_vector for transfer
			Controller_bcd_o <= convert(mm, hh);
			Controller_alarm_o <= convert(mm, hh);
			
		end if;
	end process;
end Behaviour;