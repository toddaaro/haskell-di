## Dependency Injection in Haskell

This repo is an example of doing SMD (separate modular development) in Haskell. Currently doing so
is challenging, as the Haskell module system was not designed to support this. Quotes from the
Backpack paper:

```
Suppose an author A wants to write, test, and publish a software component (or “package”) P, that
needs to call a random-number generator. But A wants each customer C to be able to supply his or
her own random-number generator. In a typed language, the author A must define the interface to the
random-number generator, typecheck P with respect to the interface, and publish P. The client C
then links P with a particular random-number generator that matches the interface. We refer to this
style of development as separate modular development (SMD), as distinct from the style of
incremental modular development (IMD) in which a package can only be typechecked when the
implementations of its dependencies are available.
```

```
Haskell’s existing module system was consciously designed as a weak namespace management system
without a proper notion of interface, and hence supports only IMD, not SMD. Tools like the Cabal
package management system pick up the slack, enabling users to (ab)use version-range dependencies
in order to work around the lack of interfaces. But the Haskell community recognizes that this is a
makeshift solution and is actively seeking ways to support SMD properly.
```

While the new Backpack system looks to solve this problem, it is still far away as a well-supported
easy-to-use part of the ecosystem, so the following is an approach we can use immediately.

### Basic Approach

The core of this approach is to use typeclasses to specify module interfaces, then create module
instances as ADTs that implement those typeclasses. The ADT acts as the module constructor, taking
in its dependency modules as arguments to its data constructor. Then the instance of the interface
typeclass for that specific ADT can consume those dependencies to provide implementations. The
approach is complicated by monadic code, but with a few type system pragmas it seems to work fine.

### Unknowns

I am not yet a proficient Haskell programmer, so it is possible this is doable in a much simpler
way. Of particular difficulty was getting the type inference to work and correctly assemble things;
playing whack a mole with pragmas got me there but hopefully not all of them are necessary.

It is also unclear how resilient this approach is to cargo culting programmers, or even
well-intentioned programmers who are under duress and don't have time to think carefully about the
whole dependency tree.
