library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity semaforos_tb is
end semaforos_tb;

architecture semaforos_tb_beh of semaforos_tb is
    signal clk_semf_tb : std_logic := '0';
    signal rst_semf_tb : std_logic := '1';
    signal ena_semf_tb : std_logic := '0';
    signal green1_tb : std_logic;
    signal yellow1_tb : std_logic;
    signal red1_tb : std_logic;
    signal green2_tb : std_logic;
    signal yellow2_tb : std_logic;
    signal red2_tb : std_logic;
begin
    SEMAFOROS_INST: entity work.semaforos(semaforos_beh)
    port map(
        clk_semf => clk_semf_tb,
        rst_semf => rst_semf_tb,
        ena_semf => ena_semf_tb,
        green1 => green1_tb,
        yellow1 => yellow1_tb,
        red1 => red1_tb,
        green2 => green2_tb,
        yellow2 => yellow2_tb,
        red2 => red2_tb);

        rst_semf_tb <= '0' after 1 us;
        ena_semf_tb <= '1' after 1 us;
        clk_semf_tb <= not clk_semf_tb after 10 ns; 
end semaforos_tb_beh;