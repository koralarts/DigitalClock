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
-- November 28, 2012
-- =============================
-- Test each of the sixteen possible inputs. Invalid inputs (values above 9)
--    result in the output displaying 
-- =============================
-- November 30, 2012
-- =============================
-- Removed clock line 
-------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity numDisplayTestBench is
end entity numDisplayTestBench;

ARCHITECTURE behv of numDisplayTestBench IS

COMPONENT NumberDisplay is port (
	    NumberDisplay_bcd_i:      in bit_vector(3 downto 0);
		NumberDisplay_segments_o: out bit_vector(6 downto 0)
    );
END COMPONENT;

signal clock : std_logic;
signal bcd: bit_vector(3 downto 0);
signal ssd: bit_vector(6 downto 0);

BEGIN
uut: numberDisplay PORT MAP (
    NumberDisplay_bcd_i => bcd,
    NumberDisplay_segments_o => ssd
   
);

tb : PROCESS
BEGIN

report "Number Display test:";
-- test 0
bcd <= "0000";
wait for 1 ns;
assert (ssd = "0000001") report "Failure in numberdisplay to display 0.";

-- test 1
bcd <= "0001";
wait for 1 ns;
assert (ssd = "1001111") report "Failure in numberdisplay to display 1.";

-- test 2
bcd <= "0010";
wait for 1 ns;
assert (ssd = "0010010") report "Failure in numberdisplay to display 2.";

-- test 3
bcd <= "0011";
wait for 1 ns;
clock <= '1';
wait for 1 ns;
clock <= '0';
assert (ssd = "0000110") report "Failure in numberdisplay to display 3.";

-- test 4
bcd <= "0100";
wait for 1 ns;
clock <= '1';
wait for 1 ns;
clock <= '0';
assert (ssd = "1001100") report "Failure in numberdisplay to display 4.";

-- test 5
bcd <= "0101";
wait for 1 ns;
assert (ssd = "0100100") report "Failure in numberdisplay to display 5.";

-- test 6
bcd <= "0110";
wait for 1 ns;
clock <= '1';
wait for 1 ns;
clock <= '0';
assert (ssd = "0100000") report "Failure in numberdisplay to display 6.";

-- test 7
bcd <= "0111";
wait for 1 ns;
assert (ssd = "0001111") report "Failure in numberdisplay to display 7.";

-- test 8
bcd <= "1000";
wait for 1 ns;
assert (ssd = "0000000") report "Failure in numberdisplay to display 8.";

-- test 9
bcd <= "1001";
wait for 1 ns;
assert (ssd = "0000100") report "Failure in numberdisplay to display 9."; -- switch last digit back to 0 to fix "0000100"

-- test A - E (values above 9)
  bcd <= "1010";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
  bcd <= "1011";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
  bcd <= "1100";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
  bcd <= "1101";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
  bcd <= "1110";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
  bcd <= "1111";
  wait for 1 ns;
  assert (ssd = "0000000") report "Failure in numberdisplay when given number >9.";
report "Test Complete";

END PROCESS;
end behv;
