library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity atrapa is
    Port (
        CLK : in  std_logic;
        Button_LEFT : in  std_logic;
        Button_RIGHT : in  std_logic;
        level1  : in STD_LOGIC;
        level2 : in STD_LOGIC;
        level3: in STD_LOGIC;
        rst : in  std_logic;
        Luces : out std_logic_vector(14 downto 0);
        win: out std_logic
    );
end atrapa;

architecture Behavioral of atrapa is

signal pos_persona : std_logic_vector(14 downto 0);
signal nivel1_act_s, nivel2_act_s, nivel3_act_s : std_logic;
signal manzanas: std_logic_vector (14 downto 0);
signal atrapa_s: std_logic;
signal no_atrapa_s : std_logic;
signal decenas_s: std_logic_vector(3 downto 0);
signal unidades_s: std_logic_vector(3 downto 0);
signal game_over_s: std_logic;
signal win_s: std_logic;
signal total: std_logic_vector( 14 downto 0);
signal campeon: std_logic;


Component persona is
    Port (
        clk: in  std_logic;
        btn_left: in  std_logic;
        btn_right: in  std_logic;
        reset: in  std_logic;
        posicion: out std_logic_vector(14 downto 0)
    );
    
end component;

Component manzana is
    Port (
        clk: in  std_logic;
        reset: in  std_logic;
        nivel1: in  std_logic;
        nivel2: in  std_logic;
        nivel3: in  std_logic;
        posicion_manzana: out std_logic_vector(14 downto 0)
    );
end component;

Component decoder is
    Port ( 
        clk: in std_logic;
        rst: in std_logic;
        posicion_persona: in std_logic_vector (14 downto 0);
        posicion_manzana: in std_logic_vector (14 downto 0);
        game_over : in std_logic;
        win: in std_logic;
        decenas  : in std_logic_vector(3 downto 0); 
        unidades : in std_logic_vector(3 downto 0); 
        leds: out std_logic_vector (14 downto 0)
);
end component;

Component pantalla is
Port ( 
        clk: in std_logic;
        reset: in std_logic;
        posicion_pantalla:  out std_logic_vector(14 downto 0);
        level1: in STD_LOGIC;
        level2: in STD_LOGIC;
        level3: in STD_LOGIC;
        win: out std_logic
        
);
end component;

Component contador is
    Port (
        clk: in  std_logic;
        rst: in  std_logic;
        level1: in  std_logic;
        level2: in  std_logic;
        level3: in  std_logic;
        manzanas: in  std_logic_vector(14 downto 0);
        pos_persona: in  std_logic_vector(14 downto 0);
        unidades_s: out std_logic_vector(3 downto 0);
        decenas_s: out std_logic_vector(3 downto 0);
        game_over_s : out std_logic;
        win_s: out std_logic;
        nivel1_act: out std_logic;
        nivel2_act: out std_logic;
        nivel3_act: out std_logic
    );
end component;

Component comparador 
    Port(
        rst: in std_logic;
        clk: in std_logic;
        posicion_persona: in std_logic_vector(14 downto 0);
        posicion_manzana: in std_logic_vector(14 downto 0);
        no_atrapa: out std_logic;
        atrapa: out std_logic
    );   
 End component;

begin
INST_persona: persona Port MAP (
    clk=>clk,
    BTN_LEFT => Button_LEFT,   
    BTN_RIGHT=> button_RIGHT,
    reset=> rst,
    posicion=> pos_persona
);

INST_manzana : manzana port map (
    clk => clk,
    reset => rst,
    nivel1 => nivel1_act_s,
    nivel2 => nivel2_act_s,
    nivel3 => nivel3_act_s,
    posicion_manzana => manzanas
);

INST_decoder : decoder Port map (
    clk=> clk,
    rst=> rst,
    posicion_persona=> pos_persona,
    posicion_manzana=> manzanas,
    game_over => game_over_s,
    win=> win_s,
    decenas=> decenas_s,
    unidades => unidades_s,
    leds=> Luces
);

INST_pantalla : pantalla port map (
    clk => clk,
    reset => rst,
    posicion_pantalla => total,
    level1 => level1,
    level2 => level2,
    level3 => level3,
    win => campeon
);

INST_contador : contador
port map (
    clk  => clk,
    rst => rst,
    level1 => level1,
    level2 => level2,
    level3 => level3,
    manzanas => manzanas,
    pos_persona => pos_persona,
    unidades_s => unidades_s,
    decenas_s=> decenas_s,
    game_over_s => game_over_s,
    win_s => win_s,
    nivel1_act=> nivel1_act_s,
    nivel2_act=> nivel2_act_s,
    nivel3_act=> nivel3_act_s
);

Inst_comparador: comparador port map (
    rst=> rst,
    clk => clk,
    posicion_persona => pos_persona,
    posicion_manzana => manzanas,
    no_atrapa => no_atrapa_s,
    atrapa => atrapa_s

);
win <= win_s;

end Behavioral;