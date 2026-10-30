{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE RankNTypes #-}
module Web.Stripe.Test.Config where

import qualified Data.ByteString.Char8 as B8

import           Web.Stripe.Client
import           System.Exit
import           System.Environment
import           Web.Stripe.Test.Prelude (Stripe)

getConfig :: (forall a. StripeConfig -> Stripe a -> IO (Either StripeError a)) -> IO StripeConfig
getConfig _stripe = maybe exitSuccess foundKey =<< lookupEnv "STRIPEKEY"
  where
    foundKey = return . flip StripeConfig Nothing . StripeKey . B8.pack
