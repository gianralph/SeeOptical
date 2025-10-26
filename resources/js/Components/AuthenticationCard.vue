<template>
    <v-container class="min-h-screen d-flex flex-column justify-center items-center pt-6 pt-0" fluid>
      <v-row justify="center">
        <v-col cols="12" sm="8" md="6">
          <v-card class="elevation-3">
            <v-card-text>
              <slot name="logo" />
              <slot />
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </template>
