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
-- 
-----------------
entity ClockDisplay is
	port( 
	    Clock: in std_logic;
	    Time: in bit_vector(15 downto 0);
			NumberDisplay0: out  bit_vector(3 downto 0); --HX:XX
			NumberDisplay1: out  bit_vector(3 downto 0); --XH:XX
			NumberDisplay2: out  bit_vector(3 downto 0); --XX:MX
			NumberDisplay3: out  bit_vector(3 downto 0) --XX:XM
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
      Clock: in std_logic;
	    Number: in std_logic_vector(3 downto 0); --BCD
			Segments: out std_logic_vector(6 downto 0)
        );
      end component;
      
      signal Number0: std_logic_vector(3 downto 0); --BCD
      signal Number1: std_logic_vector(3 downto 0); --BCD
      signal Number2: std_logic_vector(3 downto 0); --BCD
      signal Number3: std_logic_vector(3 downto 0); --BCD
      
    begin
      Display0: NumberDisplay port map( Clock=>Clock, Number=>Number0 );
      Display1: NumberDisplay port map( Clock=>Clock, Number=>Number1 );
      Display2: NumberDisplay port map( Clock=>Clock, Number=>Number2 );
      Display3: NumberDisplay port map( Clock=>Clock, Number=>Number3 );
    end struct;

