package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Dice struct {
	EqualDistr     bool
	Die            [2]int
	NumberOfThrows int
	MinDie         int
	MaxDie         int
	RangeOfDie     int
	RangeOfSum     int
	SumStatistics  [11]int
	DieStatistics  [6][6]int
}

func NewDice() *Dice {
	d := &Dice{}
	d.MinDie = 1
	d.MaxDie = 6
	d.RangeOfDie = 6
	d.RangeOfSum = 11
	return d
}

func (d *Dice) ThrowDice(equalDistr bool, numberOfThrows int) {
	d.NumberOfThrows = numberOfThrows
	d.EqualDistr = equalDistr
	rand.Seed(time.Now().UnixNano())

	if !equalDistr {
		for i := 0; i < numberOfThrows; i++ {
			dice1 := rand.Intn(d.RangeOfDie)
			dice2 := rand.Intn(d.RangeOfDie)
			d.DieStatistics[dice1][dice2]++
			d.SumStatistics[dice1+dice2]++
		}
	} else {
		for i := 0; i < numberOfThrows; i++ {
			choosedSum := rand.Intn(d.RangeOfSum)
			d.SumStatistics[choosedSum]++

			matrixSize := d.MaxDie - d.MinDie + 1
			diagonalIndex := choosedSum
			maxDiagonaIndex := d.RangeOfSum
			var row, col int

			if diagonalIndex < matrixSize {
				row = rand.Intn(diagonalIndex + 1)
				col = diagonalIndex - row
			} else {
				row = rand.Intn(maxDiagonaIndex-diagonalIndex) + matrixSize - (maxDiagonaIndex - diagonalIndex)
				col = diagonalIndex - row
			}
			d.DieStatistics[row][col]++
		}
	}
}

func (d *Dice) ResetStatistics() {
	for i := 0; i < 5; i++ {
		for j := 0; j < 5; j++ {
			d.DieStatistics[i][j] = 0
		}
	}
	for i := 0; i < 10; i++ {
		d.SumStatistics[i] = 0
	}

}

func main() {
	d := NewDice()
	d.ThrowDice(true, 1000)
	fmt.Println(d.SumStatistics)
	fmt.Println(d.DieStatistics)
	d.ResetStatistics()
	fmt.Println(d.SumStatistics)
	fmt.Println(d.DieStatistics)
}
