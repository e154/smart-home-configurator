// This file is part of the Smart Home
// Program complex distribution https://github.com/e154/smart-home
// Copyright (C) 2016-2021, Filippov Alex
//
// This library is free software: you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Library General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library.  If not, see
// <https://www.gnu.org/licenses/>.

package logging

import (
	"os"
	"strings"
	"sync"

	m "github.com/e154/smart-home-configurator/models"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

// Logging ...
type Logging struct {
	logger     *zap.Logger
	oldLogLock *sync.Mutex
}

// NewLogger ...
func NewLogger(appConfig *m.AppConfig) (logging *Logging) {

	// First, define our level-handling logic.
	highPriority := zap.LevelEnablerFunc(func(lvl zapcore.Level) bool {
		return lvl >= zapcore.WarnLevel
	})
	lowPriority := zap.LevelEnablerFunc(func(lvl zapcore.Level) bool {
		return lvl < zapcore.WarnLevel
	})

	// High-priority output should also go to standard error, and low-priority
	// output should also go to standard out.
	consoleDebugging := zapcore.Lock(os.Stdout)
	consoleErrors := zapcore.Lock(os.Stderr)

	config := zap.NewDevelopmentEncoderConfig()
	config.EncodeTime = nil
	config.EncodeLevel = CustomLevelEncoder
	config.EncodeName = CustomNameEncoder
	config.EncodeCaller = CustomCallerEncoder
	consoleEncoder := zapcore.NewConsoleEncoder(config)

	// Join the outputs, encoders, and level-handling functions into
	// zapcore.Cores, then tee the four cores together.
	core := zapcore.NewTee(
		zapcore.NewCore(consoleEncoder, consoleErrors, highPriority),
		zapcore.NewCore(consoleEncoder, consoleDebugging, lowPriority),
	)

	logging = &Logging{
		oldLogLock: &sync.Mutex{},
	}

	logger := zap.New(core, zap.AddCaller(), zap.AddCallerSkip(1))

	zap.ReplaceGlobals(logger)

	logging.logger = logger

	return
}

// CustomLevelEncoder ...
func CustomLevelEncoder(l zapcore.Level, enc zapcore.PrimitiveArrayEncoder) {
	s, ok := _levelToCapitalColorString[l]
	if !ok {
		s = _unknownLevelColor.Add(l.CapitalString())
	}
	enc.AppendString(s)
}

//TODO fix
func CustomNameEncoder(v string, enc zapcore.PrimitiveArrayEncoder) {
	var builder strings.Builder
	builder.WriteString(White.Add(v))
	builder.WriteString("                                      ")
	enc.AppendString(builder.String()[0:25])
}

// CustomCallerEncoder ...
func CustomCallerEncoder(caller zapcore.EntryCaller, enc zapcore.PrimitiveArrayEncoder) {
	enc.AppendString(caller.TrimmedPath() + " >")
}
