#include <iostream>
#include <list>
#include <fstream>
#include <sstream>
#include "city.h"

class medicalExecutive {

    public:
        void userIO();
        void fileIO();
        string fileName;
        list <city> infectedCities, quarantinedCities;

    medicalExecutive(string passedFileName) {
        fileName = passedFileName;
    }
};

// Handles file I/O, creates our list of cities using our input file.
void medicalExecutive::fileIO() {
    // Open the input file stream, check to make sure the file opened correctly, if not throw an error and return.
    ifstream fileStream(this -> fileName);

    if(!fileStream.is_open()) {
        cout << "Input file failed to open" << "\n";
        return;
    }

    // Set up of all of our values we will be pulling from the input file.
    string name, populationString, infectionString, line;
    int population, infectionLevel;

    // Pull our city information from the input file.
    while(getline(fileStream, line)) {

        stringstream ss(line);
        getline(ss, name, ',');
        getline(ss, populationString, ',');
        population = stoi(populationString);
        getline(ss, infectionString, ',');
        infectionLevel = stoi(infectionString);
    
        city newCity(name, population, infectionLevel);
        this -> infectedCities.push_front(newCity);
    }

    fileStream.close();
    
    return;
}

// Handles user I/O, calls appropriate functions when requested.
void medicalExecutive::userIO() {

     int i;

    cout << "\n" << "Make a selection: " << "\n";
    cout << "1) Increase infection level of all cities" << "\n";
    cout << "2) Increase infection level of specific city" << "\n";
    cout << "3) Print status of a specific city" << "\n";
    cout << "4) Create quarantine log" << "\n";
    cout << "5) Print all cities above an infection level" << "\n";
    cout << "6) Exit" << "\n";
    cout << "Choice: ";

    cin >> i;
    cin.ignore();

    if(i == 1) {
        cout << "\n" << "The infection level for all cities has been increased." << "\n"; 
        // Iterate through the city list and increase infection level of each city.
        // Call appropriate methods depending on the resulting infection level
        list<city>::iterator it;
        for (it = this->infectedCities.begin(); it != this->infectedCities.end(); ++it){
            it->setInfectionLevel((it->getInfectionLevel() + 1));

            if(it->getInfectionLevel() == 1) {
                cout << "City " << it->getName() << " Population before: " << it->getPopulation() << "\n";
                it->setPopulation(it->getPopulation()*0.90);
                cout << "City " << it->getName() << " Population after: " << it->getPopulation() << "\n";
            } else if (it->getInfectionLevel() == 2) {
                cout << "City " << it->getName() << " Population before: " << it->getPopulation() << "\n";
                it->setPopulation(it->getPopulation()*0.80);
                cout << "City " << it->getName() << " Population after: " << it->getPopulation() << "\n";
            } 

        }

        this -> userIO();
    } else if(i == 2) {
        string passedCityName;

        cout << "\n" << "What city do you want to infect?: " << "\n"; 
        getline (cin, passedCityName);

        cout << "Passed city name: " << passedCityName << "\n";

        this -> userIO();
    } else if(i == 3) {
        string passedCityName;

        cout << "\n" << "What city do you want the status of?: "; 

        getline (cin, passedCityName);

        list<city>::iterator it;
        for (it = this->infectedCities.begin(); it != this->infectedCities.end(); ++it){
            if(it->getName() == passedCityName) {
                cout << "Status: " << it->getName() << ", " << it->getPopulation() << ", "  << it->getInfectionLevel() << "\n";
                this -> userIO();
            }
        }

        cout << "Sorry, " << passedCityName << " is not a city in the list." << "\n";

        this -> userIO();
    } else if(i == 4) {



        this -> userIO();
    } else if(i == 5) {
        int  passedInfectionLvl;

        cout << "\n" << "Cities above what level?: "; 

        cin >> passedInfectionLvl;

        cout << "\n" << "Cities above level " << passedInfectionLvl << ":" << "\n"; 

        list<city>::iterator it;
        for (it = this->infectedCities.begin(); it != this->infectedCities.end(); ++it){
            if(it->getInfectionLevel() > passedInfectionLvl) {
                 cout << it->getName() << ", " << it->getPopulation() << ", "  << it->getInfectionLevel() << "\n";
            }
        }

        this -> userIO();
    } else if(i == 6) {
        cout << "Good bye" << "\n";
        exit(0);
    } else {
        cout << "Invalid input. Please try again." << "\n";
        this -> userIO();
    }

    return;
}

int main(int argc, char *argv[]) {

    // Check that the file containing necessary city information is passed
    if(argc <= 1) {
        std::cout << "Missing command line argument of .txt file containing cities and their information." << '\n'; 
        exit(EXIT_FAILURE);
    } 

    // Create our new medicalExecutive object, pass the file path to the city info file.
    medicalExecutive medExec (argv[1]);

    medExec.fileIO();

    // Call and start userIO
    medExec.userIO();
    
    return 0;
}