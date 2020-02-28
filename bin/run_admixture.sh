#!/bin/bash


./NGSadmix/NGSadmix -likes genolike.beagle.gz -K 2 -P 7 -o admix.k2 -minMaf 0.05

./NGSadmix/NGSadmix -likes genolike.beagle.gz -K 3 -P 7 -o admix.k3 -minMaf 0.05

./NGSadmix/NGSadmix -likes genolike.beagle.gz -K 4 -P 7 -o admix.k4 -minMaf 0.05

./NGSadmix/NGSadmix -likes genolike.beagle.gz -K 5 -P 7 -o admix.k5 -minMaf 0.05

./NGSadmix/NGSadmix -likes genolike.beagle.gz -K 6 -P 7 -o admix.k6 -minMaf 0.05
