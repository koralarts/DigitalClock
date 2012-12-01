--------------------------------------
-- Project: DigitalClock
-- 
-- File: clockTestBench.vhdl
--
-- Author: Matthew Hill
--
-- Date: November 28, 2012
--
-- Revisions: (Date and Description)
-- =============================
-- November 30, 2012
-- =============================
-- Removed slock signal 
-------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity clockTestBench is
end entity clockTestBench;

ARCHITECTURE behv of clockTestBench IS

COMPONENT Clock is port (
       Clock_clk_i: in  std_logic;
		Clock_clk_o: out std_logic
    );
END COMPONENT;

signal clkIn, clkOut : std_logic;


BEGIN
uut: clock PORT MAP (
    Clock_clk_i => clkIn,
    Clock_clk_o => clkOut
   
);

tb : PROCESS
BEGIN

report "Controller test:";
-- t01 second iteration
for I in 0 to 119 loop
  clkIn <= '1';
  wait for 1 ns;
  clkIn <= '0';
  wait for 1 ns;
end loop;
assert (clkOut = '1') report "Failure in clock test, timing issue t01. Check clock speed and test bench check frequency";
wait for 4 ns;

-- t02 second iteration
for I in 0 to 119 loop
  clkIn <= '1';
  wait for 1 ns;
  clkIn <= '0';
  wait for 1 ns;
end loop;
assert (clkOut = '1') report "Failure in clock test, timing issue t02. Most likely due to falling out of sync";
wait for 4 ns;

report "Testing Complete";
END PROCESS;
end behv;
