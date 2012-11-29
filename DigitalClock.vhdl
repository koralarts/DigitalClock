library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


-------------------------------
-- ENTITIES
-------------------------------
entity DigitalClock is
	Port( DigitalClock_clk_i:  	 in  std_logic;
			DigitalClock_set_i:		 in  std_logic;
			DigitalClock_on_i:		 in  std_logic;
			DigitalClock_set_m1_i:	 in  integer range 0 to 9;
			DigitalClock_set_m2_i:	 in  integer range 0 to 6;
			DigitalClock_set_h1_i:   in  integer range 0 to 9;
			DigitalClock_set_h2_i:	 in  integer range 0 to 2;
			DigitalClock_buzz_o: 	 out std_logic;
			DigitalClock_segment1_o: out bit_vector(6 downto 0);
			DigitalClock_segment2_o: out bit_vector(6 downto 0);
			DigitalClock_segment3_o: out bit_vector(6 downto 0);
			DigitalClock_segment4_o: out bit_vector(6 downto 0)
	);
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
		Port(	Alarm_time_i: 	 in bit_vector(15 downto 0);
				Alarm_set_m1_i: in integer;
				Alarm_set_m2_i: in integer;
				Alarm_set_h1_i: in integer;
				Alarm_set_h2_i: in integer;
				Alarm_on_i: 	 in std_logic;
				Alarm_buzz_o: 	 out std_logic
		);
	end component;
	-- Number Display
	component NumberDisplay
		Port(	NumberDisplay_bcd_i: 	  in  bit_vector(3 downto 0);
				NumberDisplay_segments_o: out bit_vector(6 downto 0)
		);
	end component;
	-------------------------------
	-- LOCAL SIGNALS
	-------------------------------
	signal pulse: std_logic := '1';
	signal cur_time: bit_vector(15 downto 0);
begin
	-------------------------------
	-- PORT MAPS
	-------------------------------
	-- Clock
	Clock_map: Clock port map( Clock_clk_i => DigitalClock_clk_i, 
										Clock_clk_o => pulse
	);
	-- Controller
	Controller_map: Controller port map( Controller_clk_i  => pulse,
													 Controller_set_i  => DigitalClock_set_i,
													 Controller_time_o => cur_time
	);
	-- Alarm
	Alarm_map: Alarm port map( Alarm_time_i 	=> cur_time,
										Alarm_set_m1_i => DigitalClock_set_m1_i,
										Alarm_set_m2_i => DigitalClock_set_m2_i,
										Alarm_set_h1_i => DigitalClock_set_h1_i,
										Alarm_set_h2_i => DigitalClock_set_h2_i,
										Alarm_on_i 		=> DigitalClock_on_i,
										Alarm_buzz_o	=> DigitalClock_buzz_o
	);
	-- Number Display
	NumberDisplay_map_m1: NumberDisplay port map( NumberDisplay_bcd_i 	  => cur_time(3 downto 0),
																 NumberDisplay_segments_o => DigitalClock_segment1_o
	);
	NumberDisplay_map_m2: NumberDisplay port map( NumberDisplay_bcd_i		  => cur_time(7 downto 4),
																 NumberDisplay_segments_o => DigitalClock_segment2_o
	);
	NumberDisplay_map_h1: NumberDisplay port map( NumberDisplay_bcd_i		  => cur_time(11 downto 8),
																 NumberDisplay_segments_o => DigitalClock_segment3_o
	);
	NumberDisplay_map_h2: NumberDisplay port map( NumberDisplay_bcd_i		  => cur_time(15 downto 12),
																 NumberDisplay_segments_o => DigitalClock_segment4_o
	);
end Behaviour; 