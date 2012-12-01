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
-- 
-------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity controllerTestBench is
end entity controllerTestBench;

ARCHITECTURE behv of controllerTestBench IS

COMPONENT Controller is port (
	 Controller_set_i:	 in  std_logic;
	 Controller_time_o: out bit_vector(15 downto 0)
    );
END COMPONENT;

signal set : std_logic;
signal currTime: bit_vector(15 downto 0);


BEGIN
uut: controller PORT MAP (
    Controller_set_i => set,
    Controller_time_o => currTime
   
);

tb : PROCESS
BEGIN

report "Controller test:";
-- t01 count out a few minutes
for I in 0 to 10 loop
  set <= '0';
  wait for 1 ns;
  set <='1';
  wait for 1 ns;
end loop;
assert (currTime = "0000000000000000") report "Failure in controller initial state test t01.";

END PROCESS;
end behv;



