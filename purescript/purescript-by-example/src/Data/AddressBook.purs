module Data.AddressBook where

import Prelude

import Control.Plus (empty)
import Data.List (List(..), filter, head)
import Data.Maybe (Maybe)

-- Type definitions

-- The entry and address types are both records with know attributes
type Entry =
  { firstName :: String
  , lastName :: String
  , address :: Address
  }

type Address =
  { street :: String
  , city :: String
  , state :: String
  }

-- Shorthand types for documentation purposes
type AddressBook = List Entry
type FirstName = String
type LastName = String

-- A function that converts a entry and its associated address into a
-- string. This can then be logged
showEntry :: Entry -> String
showEntry entry =
  entry.lastName <> ", " <>
  entry.firstName <> ", " <>
  showAddress entry.address

-- Same as show entry but for addresses
showAddress :: Address -> String
showAddress address =
  address.street <> ", " <>
  address.city <> ", " <>
  address.state

-- Get a Type AddressBook with no entries
-- Esentially get an empty List of type List Entry
emptyBook :: AddressBook
emptyBook = empty

-- | > insertEntry
-- | Insert an entry into an addressbook
-- | This uses eta conversion to remove the args on both sides (point free form)
-- |
-- | Method
-- | insertEntry entry book = Cons entry book
-- | We can rewrite this to show how the function is interpreted
-- |
-- | insertEntry entry book = (Cons entry) book
-- | But through currying we can now think of insertEntry as a
-- | function that passes a param to (Cons entry)
-- |
-- | insertEntry entry = Cons entry
-- | So we rewrite it like this, but we can apply the same idea
-- | again which gives us the definition below
insertEntry :: Entry -> AddressBook -> AddressBook
insertEntry = Cons


-- | > findEntry
-- | This function takes a FirstName, LastName and AddressBook
-- | and returns a type Maybe Entry
-- |
-- | > head $ filter
-- | The results of filter is fed into the head function
-- | We need this since our filter returns a type List Entry
-- | but we only want one matching entry so we get the head
-- |
-- | > filterEntry book where
-- | This line applies the filterEntry function to the AddressBook
-- | we passed in. fitlerEntry is defined after the where clause
-- |
-- | > filterEntry
-- | This function takes an Entry type and returns a Boolean by
-- | matching some of the record properties
-- |
-- | This function is defined within the scope of findEntry, which
-- | means it is not accessible outside of findEntry. Note the
-- | type definition is optional and we can access other variables
-- | from the current scope
-- |
-- | REWRITE
-- | > head <<< filter filterEntry
-- | We can rewrite the above composition using the backwards
-- | composition operator. This also allows us to remove the
-- | explicit book definition
findEntry :: FirstName -> LastName -> AddressBook -> Maybe Entry
findEntry firstName lastName = head <<< filter filterEntry
  where
  filterEntry :: Entry -> Boolean
  filterEntry entry = entry.firstName == firstName && entry.lastName == lastName
