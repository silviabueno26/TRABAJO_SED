library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity persona is
Port (
        clk: in  std_logic;
        reset: in  std_logic;
        btn_left: in  std_logic;
        btn_right: in  std_logic;
        posicion: out std_logic_vector(14 downto 0)
    );
end persona;

architecture Behavioral of persona is
signal sync_left, sync_right : std_logic;
signal edge_left, edge_right : std_logic;

component SYNCHRNZR is
port (
            CLK: in  std_logic;
            ASYNC_IN: in  std_logic;
            SYNC_OUT: out std_logic
);
end component;

component SYNCHRNZR2 is
    port (
            CLK: in  std_logic;
            ASYNC_IN2: in  std_logic;
            SYNC_OUT2: out std_logic
);
end component;

component EDGEDTCTR is
port(
            CLK: in  std_logic;
            SYNC_IN: in  std_logic;
            EDGE: out std_logic
);
end component;
component EDGEDTCTR2 is
        port (
            CLK: in  std_logic;
            SYNC_IN2: in  std_logic;
            EDGE2: out std_logic
);
end component;

begin

INST_SYNCHRNZR1: SYNCHRNZR
        port map(
            CLK => clk,
            ASYNC_IN=> btn_left,
            SYNC_OUT=> sync_left
);

INST_SYNCHRNZR2: SYNCHRNZR2
        port map(
            CLK=> clk,
            ASYNC_IN2 => btn_right,
            SYNC_OUT2 => sync_right
 );
        
INST_EDGEDTCTR1: EDGEDTCTR
        port map(
            CLK=> clk,
            SYNC_IN => sync_left,
            EDGE => edge_left
);

INST_EDGEDTCTR2: EDGEDTCTR2
        port map(
            CLK => clk,
            SYNC_IN2 => sync_right,
            EDGE2 => edge_right
);
end Behavioral;
