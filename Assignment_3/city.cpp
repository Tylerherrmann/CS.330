#include "city.h"

city::city(string passedName, int passedPopulation, int passedInfectionLvl){
    setCity(passedName, passedPopulation, passedInfectionLvl);
}
 

void city::setCity(string passedName, int passedPopulation, int passedInfectionLvl) {
    name = passedName;
    population = passedPopulation;
    infectionLevel = passedInfectionLvl;
}


void city::setInfectionLevel(int passedInfectionLvl) {
    infectionLevel = passedInfectionLvl;
}

void city::setPopulation(int passedPopulation) {
    population = passedPopulation;
}