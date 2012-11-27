--------------------------------------
-- Project: DigitalClock
-- 
-- File: ClockDisplay.vhdl
--
-- Author: James Brennan
--
-- Date: November 17, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 26, 2012
-- =============================
--
-- Added ClockDisplay_clk_i
-- Removed ClockDisplay_minute_i
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
-- Import ClockDisplayNumber.vhdl
use work.all;

-----------------
-- ClockDisplay
--
-- Notes:
-- Based on the code found in VHDL Guru
-- http://vhdlguru.blogspot.ca/2010/03/vhdl-code-for-bcd-to-7-segment-display.html
-----------------
entity ClockDisplay is
	port( ClockDisplay_clk_i: in std_logic;
			ClockDisplay_bcd_i: in bit_vector(15 downto 0)
		  );
end ClockDisplay;

-----------------
-- Behaviour
--
-- Notes:
-- 
-----------------
architecture Behaviour of ClockDisplay is

begin
	
end Behaviour;

architecture struct of ClockDisplay is
  component NumberDisplay is
    port( NumberDisplay_clk_i:   in  std_logic;
	       NumberDisplay_bcd_i:      in  bit_vector(3 downto 0); --BCD
			 NumberDisplay_segments_o: out bit_vector(6 downto 0)
        );
      end component;
      
    begin
      Display0: NumberDisplay port map( NumberDisplay_clk_i => ClockDisplay_clk_i, NumberDisplay_bcd_i => ClockDisplay_bcd_i(3 downto 0));
      Display1: NumberDisplay port map( NumberDisplay_clk_i => ClockDisplay_clk_i, NumberDisplay_bcd_i => ClockDisplay_bcd_i(7 downto 4));
      Display2: NumberDisplay port map( NumberDisplay_clk_i => ClockDisplay_clk_i, NumberDisplay_bcd_i => ClockDisplay_bcd_i(11 downto 8));
      Display3: NumberDisplay port map( NumberDisplay_clk_i => ClockDisplay_clk_i, NumberDisplay_bcd_i => ClockDisplay_bcd_i(15 downto 12));
    end struct;

