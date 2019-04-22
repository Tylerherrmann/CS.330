#ifndef CITY_H_
#define CITY_H_
#include <string>
using namespace std;

class city {

    private:
        string name;
        int population;
        int infectionLevel;

    public:
        city(string passedName, int passedPopulation, int passedInfectionLvl);

        bool operator == (city b) {return name == b.name;}
        bool operator != (city b) {return name != b.name;}

        void setCity(string passedName, int passedPopulation, int passedInfectionLvl);
        void setPopulation(int passedPopulation);
        void setInfectionLevel(int passedInfectionLvl);

        string getName() {return name;}
        int getPopulation() {return population;}
        int getInfectionLevel() {return infectionLevel;}
};

#endif