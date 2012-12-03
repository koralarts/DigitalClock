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
-- ==============================
-- November 24, 2012
-- ==============================
-- 
-- Added Alarm_set_m1_i
-- Added Alarm_set_m2_i
-- Added Alarm_set_h1_i
-- Added Alarm_set_h2_i
-- Removed Alarm_set_min_i
-- Removed Alarm_set_hur_i
--
-- Replaced the convert function to
-- accomodate single integer input.
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
port( Alarm_time_i: in bit_vector(15 downto 0); -- Current time
Alarm_set_m1_i: in integer; -- Set Minute ones place
Alarm_set_m2_i: in integer; -- Set Minute tens place
Alarm_set_h1_i: in integer; -- Set Hour ones place
Alarm_set_h2_i: in integer; -- Set Hour tens place
Alarm_on_i:	in	std_logic; -- Alarm on or off (1 = on, 0 = off)
Alarm_buzz_o:	out std_logic -- BUZZ! (1 = buzz, 0 = no buzz)
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
variable ret:	bit_vector(15 downto 0);

begin
min_bits(7 downto 4) := to_bitvector(std_logic_vector(to_unsigned(m2, 4)));
min_bits(3 downto 0) := to_bitvector(std_logic_vector(to_unsigned(m1, 4)));
hur_bits(7 downto 4) := to_bitvector(std_logic_vector(to_unsigned(h2, 4)));
hur_bits(3 downto 0) := to_bitvector(std_logic_vector(to_unsigned(h1, 4)));
ret(7 downto 0) := min_bits;
ret(15 downto 8) := hur_bits;

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
  process(Alarm_time_i, Alarm_on_i)
  begin
    if Alarm_on_i = '1' then -- Check if alarm is on
      bit_alarm <= convert(Alarm_set_m1_i, Alarm_set_m2_i,
                            Alarm_set_h1_i, Alarm_set_h2_i); -- Convert to bit vectors
      if bit_alarm = Alarm_time_i then -- Compare if current time equals alarm time
        Alarm_buzz_o <= '1'; -- BUZZ!
      else
        Alarm_buzz_o <= '0'; -- NO BUZZ!
      end if;
    else
      Alarm_buzz_o <= '0'; -- no buzz if alarm is turned off.
    end if;
  end process;
end Behaviour;


