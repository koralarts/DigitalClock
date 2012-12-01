--------------------------------------
-- Project: DigitalClock
-- 
-- File: numDisplayTestBench.vhdl
--
-- Author: Matthew Hill
--
-- Date: November 28, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 30, 2012
-- =============================
-- Removed clock signal 
-------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity alarmTestBench is
end entity alarmTestBench;

ARCHITECTURE behv of alarmTestBench IS

COMPONENT Alarm is port (
          Alarm_time_i:    in  bit_vector(15 downto 0); -- Current time
           Alarm_set_m1_i:  in  integer; -- Set Minute ones place
           Alarm_set_m2_i:  in  integer; -- Set Minute tens place
           Alarm_set_h1_i:  in  integer; -- Set Hour ones place
           Alarm_set_h2_i:  in  integer; -- Set Hour tens place
           Alarm_on_i:          in    std_logic; -- Alarm on or off (1 = on, 0 = off)
           Alarm_buzz_o:      out std_logic -- BUZZ! (1 = buzz, 0 = no buzz)
    );
END COMPONENT;

signal min1, min2, hr1, hr2 : integer;
signal currTime : bit_vector (15 downto 0);
signal almOn: std_logic;
signal buzz : std_logic;

BEGIN
uut: alarm PORT MAP (
    Alarm_time_i => currTime,
    Alarm_set_m1_i => min1,
    Alarm_set_m2_i => min2,
    Alarm_set_h1_i => hr1,
    Alarm_set_h2_i => hr2,
    Alarm_on_i => almOn,
    Alarm_buzz_o => buzz
);

tb : PROCESS
BEGIN

report "Alarm test:";
-- t01 all zeroes silent
buzz <= '0'; -- set initial state or else undefined.
currTime <= "0000000000000001"; -- must have a different initial time then the time to be tested 
wait for 1 ns;
currTime <= "0000000000000000";
min1 <= 0;
min2 <= 0;
hr1 <= 0;
hr2 <= 0;
almOn <= '0';
wait for 1 ns;
assert (buzz = '0') report "Failure in alarm test t01.";
wait for 1 ns;

--t02 buzz on match
currTime <= "0000000000000000";
min1 <= 0;
min2 <= 0;
hr1 <= 0;
hr2 <= 0;
almOn <= '1';
wait for 4 ns;
assert (buzz = '1') report "Failure in alarm test t02.";
wait for 1 ns;

--t03 kill buzz
currTime <= "0000000000000000";
min1 <= 0;
min2 <= 0;
hr1 <= 0;
hr2 <= 0;
almOn <= '0';
wait for 1 ns;
assert (buzz = '0') report "Failure in alarm test t03.";
wait for 1 ns;

--t04 different values in each spot no alarm
currTime <= "0000000000000001";
min1 <= 1;
min2 <= 2;
hr1 <= 3;
hr2 <= 4;
almOn <= '1';
wait for 1 ns;
assert (buzz = '0') report "Failure in alarm test t04.";
wait for 1 ns;

--t05 match one min buzz
currTime <= "0000000000000001";
min1 <= 1;
min2 <= 0;
hr1 <= 0;
hr2 <= 0;
almOn <= '1';
wait for 1 ns;
assert (buzz = '1') report "Failure in alarm test t05.";
wait for 1 ns;
--t06
currTime <= "0001000000000000";
min1 <= 0;
min2 <= 0;
hr1 <= 0;
hr2 <= 1;
almOn <= '1';
wait for 1 ns;
assert (buzz = '1') report "Failure in alarm test t06.";
wait for 1 ns;
--t07 
currTime <= "1000010000010010";
min1 <= 2;
min2 <= 1;
hr1 <= 4;
hr2 <= 8;
almOn <= '1';
wait for 1 ns;
assert (buzz = '1') report "Failure in alarm test t07.";
wait for 1 ns;
--t08 kill buzz
currTime <= "0000010000100000";
min1 <= 0;
min2 <= 2;
hr1 <= 4;
hr2 <= 0;
almOn <= '0';
wait for 1 ns;
assert (buzz = '0') report "Failure in alarm test t08.";
wait for 1 ns;
report "Alarm test Complete";
wait;
END PROCESS;
end behv;
