﻿using System;
using Moq;
using Serilog.Configuration;
using Serilog.Core;
using Serilog.Events;
using Serilog.Formatting;
using Serilog.Sinks.MSSqlServer.Configuration.Factories;
using Serilog.Sinks.MSSqlServer.Tests.TestUtils;
using Serilog.Sinks.PeriodicBatching;
using Xunit;

namespace Serilog.Sinks.MSSqlServer.Tests.Configuration.Extensions.System.Configuration
{
    [Trait(TestCategory.TraitName, TestCategory.Unit)]
    public class LoggerConfigurationMSSqlServerExtensionsTests
    {
        private readonly LoggerConfiguration _loggerConfiguration;
        private readonly Mock<IApplySystemConfiguration> _applySystemConfigurationMock;

        public LoggerConfigurationMSSqlServerExtensionsTests()
        {
            _loggerConfiguration = new LoggerConfiguration();
            _applySystemConfigurationMock = new Mock<IApplySystemConfiguration>();
        }

        [Fact]
        public void MSSqlServerCallsApplySystemGetSectionWithSectionName()
        {
            // Arrange
            const string inputSectionName = "TestConfigSectionName";
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: inputSectionName,
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.GetSinkConfigurationSection(inputSectionName),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsApplySystemConfigurationGetConnectionString()
        {
            // Arrange
            const string inputConnectionString = "TestConnectionString";
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(new MSSqlServerConfigurationSection());
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: inputConnectionString,
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.GetConnectionString(inputConnectionString),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsSinkFactoryWithConnectionStringFromSystemConfig()
        {
            // Arrange
            const string configConnectionString = "TestConnectionStringFromConfig";
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.GetConnectionString(It.IsAny<string>()))
                .Returns(configConnectionString);
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            sinkFactoryMock.Verify(f => f.Create(configConnectionString, It.IsAny<MSSqlServerSinkOptions>(), It.IsAny<IFormatProvider>(),
                It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>(), It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsApplySystemConfigurationGetColumnOptions()
        {
            // Arrange
            var columnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            var systemConfigSection = new MSSqlServerConfigurationSection();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(systemConfigSection);
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: columnOptions,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureColumnOptions(systemConfigSection, columnOptions),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsSinkFactoryWithColumnOptionsFromSystemConfig()
        {
            // Arrange
            var configColumnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
               .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.ConfigureColumnOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>()))
                .Returns(configColumnOptions);
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            sinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), It.IsAny<MSSqlServerSinkOptions>(),
                It.IsAny<IFormatProvider>(), configColumnOptions, It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerDoesNotCallApplySystemConfigurationGetColumnOptionsWhenNotUsingSystemConfig()
        {
            // Arrange
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureColumnOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>()),
                Times.Never);
        }

        [Fact]
        public void MSSqlServerCallsApplySystemConfigurationGetSinkOptions()
        {
            // Arrange
            var sinkOptions = new MSSqlServerSinkOptions();
            var systemConfigSection = new MSSqlServerConfigurationSection();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(systemConfigSection);
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: sinkOptions,
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureSinkOptions(systemConfigSection, sinkOptions),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsSinkFactoryWithSinkOptionsFromSystemConfig()
        {
            // Arrange
            var configSinkOptions = new MSSqlServerSinkOptions();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
               .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.ConfigureSinkOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(configSinkOptions);
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            sinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), configSinkOptions,
                It.IsAny<IFormatProvider>(), It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>(), It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerDoesNotCallApplySystemConfigurationGetSinkOptionsWhenNotUsingSystemConfig()
        {
            // Arrange
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureSinkOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<MSSqlServerSinkOptions>()),
                Times.Never);
        }

        [Fact]
        public void MSSqlServerCallsSinkFactoryWithSuppliedParameters()
        {
            // Arrange
            var sinkOptions = new MSSqlServerSinkOptions { TableName = "TestTableName" };
            var columnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            var formatProviderMock = new Mock<IFormatProvider>();
            var logEventFormatterMock = new Mock<ITextFormatter>();
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            periodicBatchingSinkFactoryMock.Setup(f => f.Create(It.IsAny<MSSqlServerSink>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(new Mock<ILogEventSink>().Object);
            _applySystemConfigurationMock.Setup(c => c.GetConnectionString(It.IsAny<string>()))
                .Returns<string>(c => c);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: sinkOptions,
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: formatProviderMock.Object,
                columnOptions: columnOptions,
                logEventFormatter: logEventFormatterMock.Object,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            sinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), sinkOptions, formatProviderMock.Object,
                columnOptions, logEventFormatterMock.Object), Times.Once);
        }

        [Fact]
        public void MSSqlServerCallsBatchedSinkFactoryWithSinkFromSinkFactoryAndSuppliedSinkOptions()
        {
            // Arrange
            var sinkOptions = new MSSqlServerSinkOptions();
            var sinkMock = new Mock<IBatchedLogEventSink>();
            var sinkFactoryMock = new Mock<IMSSqlServerSinkFactory>();
            var periodicBatchingSinkFactoryMock = new Mock<IPeriodicBatchingSinkFactory>();
            sinkFactoryMock.Setup(f => f.Create(It.IsAny<string>(), It.IsAny<MSSqlServerSinkOptions>(), It.IsAny<IFormatProvider>(),
                It.IsAny<MSSqlServer.ColumnOptions>(), It.IsAny<ITextFormatter>()))
                .Returns(sinkMock.Object);

            // Act
            _loggerConfiguration.WriteTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: sinkOptions,
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                sinkFactory: sinkFactoryMock.Object,
                batchingSinkFactory: periodicBatchingSinkFactoryMock.Object);

            // Assert
            periodicBatchingSinkFactoryMock.Verify(f => f.Create(sinkMock.Object, sinkOptions), Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsApplySystemGetSectionWithSectionName()
        {
            // Arrange
            const string inputSectionName = "TestConfigSectionName";
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: inputSectionName,
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.GetSinkConfigurationSection(inputSectionName),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsApplySystemConfigurationGetConnectionString()
        {
            // Arrange
            const string inputConnectionString = "TestConnectionString";
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(new MSSqlServerConfigurationSection());
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: inputConnectionString,
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.GetConnectionString(inputConnectionString),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsSinkFactoryWithConnectionStringFromSystemConfig()
        {
            // Arrange
            const string configConnectionString = "TestConnectionStringFromConfig";
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.GetConnectionString(It.IsAny<string>()))
                .Returns(configConnectionString);
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            auditSinkFactoryMock.Verify(f => f.Create(configConnectionString, It.IsAny<MSSqlServerSinkOptions>(), It.IsAny<IFormatProvider>(),
                It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>(), It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsApplySystemConfigurationGetColumnOptions()
        {
            // Arrange
            var columnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            var systemConfigSection = new MSSqlServerConfigurationSection();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(systemConfigSection);
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: columnOptions,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureColumnOptions(systemConfigSection, columnOptions),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsSinkFactoryWithColumnOptionsFromSystemConfig()
        {
            // Arrange
            var configColumnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
               .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.ConfigureColumnOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>()))
                .Returns(configColumnOptions);
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            auditSinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), It.IsAny<MSSqlServerSinkOptions>(), It.IsAny<IFormatProvider>(),
                configColumnOptions, It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditDoesNotCallApplySystemConfigurationGetColumnOptionsWhenNotUsingSystemConfig()
        {
            // Arrange
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureColumnOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>()),
                Times.Never);
        }

        [Fact]
        public void MSSqlServerAuditCallsApplySystemConfigurationGetSinkOptions()
        {
            // Arrange
            var sinkOptions = new MSSqlServerSinkOptions();
            var systemConfigSection = new MSSqlServerConfigurationSection();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
                .Returns(systemConfigSection);
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: sinkOptions,
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureSinkOptions(systemConfigSection, sinkOptions),
                Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditCallsSinkFactoryWithSinkOptionsFromSystemConfig()
        {
            // Arrange
            var configSinkOptions = new MSSqlServerSinkOptions();
            _applySystemConfigurationMock.Setup(c => c.GetSinkConfigurationSection(It.IsAny<string>()))
               .Returns(new MSSqlServerConfigurationSection());
            _applySystemConfigurationMock.Setup(c => c.ConfigureSinkOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<MSSqlServerSinkOptions>()))
                .Returns(configSinkOptions);
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: new Serilog.Sinks.MSSqlServer.ColumnOptions(),
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            auditSinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), configSinkOptions, It.IsAny<IFormatProvider>(),
                It.IsAny<Serilog.Sinks.MSSqlServer.ColumnOptions>(), It.IsAny<ITextFormatter>()), Times.Once);
        }

        [Fact]
        public void MSSqlServerAuditDoesNotCallApplySystemConfigurationGetSinkOptionsWhenNotUsingSystemConfig()
        {
            // Arrange
            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: new MSSqlServerSinkOptions { TableName = "TestTableName" },
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: null,
                columnOptions: null,
                logEventFormatter: null,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            _applySystemConfigurationMock.Verify(c => c.ConfigureSinkOptions(It.IsAny<MSSqlServerConfigurationSection>(), It.IsAny<MSSqlServerSinkOptions>()),
                Times.Never);
        }

        [Fact]
        public void MSSqlServerAuditCallsSinkFactoryWithSuppliedParameters()
        {
            // Arrange
            var sinkOptions = new MSSqlServerSinkOptions { TableName = "TestTableName" };
            var columnOptions = new Serilog.Sinks.MSSqlServer.ColumnOptions();
            var formatProviderMock = new Mock<IFormatProvider>();
            var logEventFormatterMock = new Mock<ITextFormatter>();

            var auditSinkFactoryMock = new Mock<IMSSqlServerAuditSinkFactory>();

            // Act
            _loggerConfiguration.AuditTo.MSSqlServerInternal(
                configSectionName: "TestConfigSectionName",
                connectionString: "TestConnectionString",
                sinkOptions: sinkOptions,
                restrictedToMinimumLevel: LevelAlias.Minimum,
                formatProvider: formatProviderMock.Object,
                columnOptions: columnOptions,
                logEventFormatter: logEventFormatterMock.Object,
                applySystemConfiguration: _applySystemConfigurationMock.Object,
                auditSinkFactory: auditSinkFactoryMock.Object);

            // Assert
            auditSinkFactoryMock.Verify(f => f.Create(It.IsAny<string>(), sinkOptions, formatProviderMock.Object,
                columnOptions, logEventFormatterMock.Object), Times.Once);
        }
    }
}
