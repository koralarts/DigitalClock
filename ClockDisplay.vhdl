--------------------------------------
-- DigitalClock.vhdl
--
-- Author: James Brennan
--
-- Date: November 17, 2012
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
	port( 
	    ClockDisplay_minute_i: in std_logic;
	    ClockDisplay_bcd_i: in bit_vector(15 downto 0);
			ClockDisplay_NumberDisplay_0_o: out  bit_vector(3 downto 0); --HX:XX
			ClockDisplay_NumberDisplay_1_o: out  bit_vector(3 downto 0); --XH:XX
			ClockDisplay_NumberDisplay_2_o: out  bit_vector(3 downto 0); --XX:MX
			ClockDisplay_NumberDisplay_3_o: out  bit_vector(3 downto 0) --XX:XM
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
    port(
      NumberDisplay_minute_i: in std_logic;
	    NumberDisplay_bcd_i: in std_logic_vector(3 downto 0); --BCD
			NumberDisplay_segments_o: out std_logic_vector(6 downto 0)
        );
      end component;
      
      signal bcd_0: std_logic_vector(3 downto 0); --BCD
      signal bcd_1: std_logic_vector(3 downto 0); --BCD
      signal bcd_2: std_logic_vector(3 downto 0); --BCD
      signal bcd_3: std_logic_vector(3 downto 0); --BCD
      
    begin
      Display0: NumberDisplay port map( NumberDisplay_minute_i => ClockDisplay_minute_i, NumberDisplay_bcd_i => bcd_0 );
      Display1: NumberDisplay port map( NumberDisplay_minute_i => ClockDisplay_minute_i, NumberDisplay_bcd_i => bcd_1 );
      Display2: NumberDisplay port map( NumberDisplay_minute_i => ClockDisplay_minute_i, NumberDisplay_bcd_i => bcd_2 );
      Display3: NumberDisplay port map( NumberDisplay_minute_i => ClockDisplay_minute_i, NumberDisplay_bcd_i => bcd_3 );
    end struct;

