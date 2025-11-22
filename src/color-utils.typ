
// ------ COLOR UTILS -------

// #let color-cycle-factory(count, colors: (blue, red, green, orange, purple)) = {
//   let color-cycle() = {
//     count.step()
//     let color-i() = calc.rem(count.get().at(0) - 1, colors.len())
//     colors.at(color-i())
//   }
//   color-cycle
// }

// OKAY apparently you cannot compose anything with context which is STUPID. They all have to be in one function.
// #let gatbox-color-cycle = color-cycle-factory(gatbox-color-counter)

// #let cycle-a-counter = counter("color-cycle-a")
// #let cycle-a = color-cycle-factory(cycle-a-counter)

// #let cycle-b-counter = counter("color-cycle-b")
// #let cycle-b = color-cycle-factory(cycle-b-counter, colors: (white, black))

// For the love of god cannot get this to work
// #let color-cycle-counter = counter("color-cycle-counter")
// #let ColorCycle(
//   colors: (blue, red, green, orange, purple),
// ) = {
//   let counter-id() = color-cycle-counter.get().at(0)
//   color-cycle-counter.step()
//   let count() = counter("color-cycle-" + str(counter-id()))
//   return count()
// }

// #let cycle-0 = ColorCycle
// #let cycle-1 = ColorCycle


// #let ColorCycle(counter-name, colors: (blue, red, green, orange, purple)) = {
//   let count = counter(counter-name)
//   let color-cycle() = {
//     count.step()
//     let color-i() = calc.rem(count.get().at(0) - 1, colors.len())
//     colors.at(color-i())
//   }
//   color-cycle
// }