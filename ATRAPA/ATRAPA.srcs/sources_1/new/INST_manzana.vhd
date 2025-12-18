library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity manzana is
    Port (
        clk: in  std_logic;
        reset: in  std_logic;
        nivel1: in  std_logic;
        nivel2: in  std_logic;
        nivel3: in  std_logic;
        posicion_manzana: out std_logic_vector(14 downto 0)
    );
end manzana;

architecture Behavioral of manzana is

    signal sync_l1, sync_l2, sync_l3 : std_logic;
    signal edge_l1,edge_l2, edge_l3: std_logic;

component SYNCHRNZR_MANZ1 is
    port (
            CLK: in  std_logic;
            ASYNC1_IN: in  std_logic;
            SYNC1_OUT: out std_logic
);
end component;

component SYNCHRNZR_MANZ2 is
    port (
            CLK: in  std_logic;
            ASYNC2_IN: in  std_logic;
            SYNC2_OUT: out std_logic
);
end component;

component SYNCHRNZR_MANZ3 is
    port (
            CLK: in  std_logic;
            ASYNC3_IN : in  std_logic;
            SYNC3_OUT : out std_logic
);
end component;
    

begin

INST_SYNCHRNZR_MANZ1: SYNCHRNZR_MANZ1 port map(
        CLK  => clk,
        ASYNC1_IN => nivel1,
        SYNC1_OUT => sync_l1
);

INST_SYNCHRNZR_MANZ2: SYNCHRNZR_MANZ2 port map(
        CLK=> clk,
        ASYNC2_IN => nivel2,
        SYNC2_OUT => sync_l2
);

INST_SYNCHRNZR_MANZ3: SYNCHRNZR_MANZ3 port map(
        CLK=> clk,
        ASYNC3_IN => nivel3,
        SYNC3_OUT => sync_l3
);

end Behavioral;