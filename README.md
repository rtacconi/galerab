# GALERAD
Load balancer for MySql clusters using Galera replication, or for Percona XtraDB Custer.

## Installation

```bash
gem install galerab
rake install:debian # for debian/ubuntu
```

This installation is for Debian-like systems to link the script to the system levels.

# Usage

```bash
service galerab start
service galerab stop
```

# Testing

To run rspec:

```bash
rake
```