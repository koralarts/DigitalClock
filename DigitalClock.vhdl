library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


-------------------------------
-- ENTITIES
-------------------------------
entity DigitalClock is
	Port( DigitalClock_clk_i: in std_logic);
end DigitalClock;

architecture Behaviour of DigitalClock is
	-------------------------------
	-- COMPONENTS
	-------------------------------
	-- Clock
	component Clock
		Port( Clock_clk_i: in  std_logic;
				Clock_clk_o: out std_logic
		);
	end component;
	-- Controller
	component Controller
		Port( Controller_clk_i:  in  std_logic;
				Controller_set_i:  in  std_logic;
				Controller_time_o: out bit_vector(15 downto 0)
		);
	end component;
	-- Alarm
	component Alarm
		Port( Alarm_clk_i: 	 in std_logic;
				Alarm_time_i: 	 in bit_vector(15 downto 0);
				Alarm_set_m1_i: in integer;
				Alarm_set_m2_i: in integer;
				Alarm_set_h1_i: in integer;
				Alarm_set_h2_i: in integer;
				Alarm_on_i: 	 in std_logic;
				Alarm_buzz_o: 	 out std_logic
		);
	end component;
	-- Number Display
	component ClockDisplay
		Port( ClockDisplay_clk_i: in  std_logic;
				ClockDisplay_bcd_i: in  bit_vector(15 downto 0)
		);
	end component;
	
	-------------------------------
	-- LOCAL SIGNALS
	-------------------------------
	signal set: std_logic;
	signal clk_i: std_logic;
	signal clk_o: std_logic;
	signal alarm_on: std_logic;
	signal buzz: std_logic;
	signal cur_time: bit_vector(15 downto 0);
	signal set_m1: integer;
	signal set_m2: integer;
	signal set_h1: integer;
	signal set_h2: integer;
begin
	-------------------------------
	-- Initializations
	-------------------------------
	alarm_on <= '0';
	set_m1 <= 0;
	set_m2 <= 0;
	set_h1 <= 0;
	set_h2 <= 0;
	-------------------------------
	-- PORT MAPS
	-------------------------------
	-- Clock
	Clock_map: Clock port map( Clock_clk_i => clk_i, 
										Clock_clk_o => clk_o
	);
	-- Controller
	Controller_map: Controller port map( Controller_clk_i => clk_o,
													 Controller_set_i => set,
													 Controller_time_o => cur_time
	);
	-- Alarm
	Alarm_map: Alarm port map( Alarm_time_i 	=> cur_time,
										Alarm_clk_i 	=> clk_i,
										Alarm_set_m1_i => set_m1,
										Alarm_set_m2_i => set_m2,
										Alarm_set_h1_i => set_h1,
										Alarm_set_h2_i => set_h2,
										Alarm_on_i 		=> alarm_on,
										Alarm_buzz_o	=> buzz
	);
	-- Clock Display
	ClockDisplay_map: ClockDisplay port map( ClockDisplay_clk_i => clk_o,
														  ClockDisplay_bcd_i => cur_time
	);
	
	process(DigitalClock_clk_i)
	begin
		if DigitalClock_clk_i = '1' then
			clk_i <= '1';
		else
			clk_i <= '0';
		end if;
	end process;
end Behaviour;