#!/bin/bash

sqlite3 wc.db < create.sql
sqlite3 wc.db < insert.sql
