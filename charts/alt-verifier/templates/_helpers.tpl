{{/*
Expand the name of the chart.
*/}}
{{- define "alt-verifier.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alt-verifier.fullname" -}}
{{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
        {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
        {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}
{{- end }}

{{- define "alt-verifier.secretName" -}}
{{- $fullname := include "alt-verifier.fullname" $ -}}
{{- default $fullname $.Values.secret.name -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alt-verifier.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alt-verifier.labels" -}}
helm.sh/chart: {{ include "alt-verifier.chart" . }}
{{ include "alt-verifier.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alt-verifier.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alt-verifier.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alt-verifier.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alt-verifier.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Check and assemble the Image:Tag
*/}}
{{- define "alt-verifier.image" -}}
    {{- $tag := default .Chart.AppVersion .Values.image.tag -}}
    {{- $image := printf "%s:%s" .Values.image.repository $tag }}
    {{- $image -}}
{{- end }}


{{- define "ingress.APIVersion" -}}
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
{{- "networking.k8s.io/v1" }}
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
{{- "networking.k8s.io/v1beta1" }}
{{- else }}
{{- "networking.k8s.io/v1beta1" }}
{{- end }}
{{- end }}


{{- define "camelToDashArgs" -}}
{{- range $k, $v := . }}
{{- if $v }}
    {{- if eq (toString $v) "true" }}
--{{ kebabcase $k }}
    {{- else if (kindIs "slice" $v)}}
        {{- range $vi := $v}}
--{{ kebabcase $k }}={{ tpl (toString $vi) $ | quote }}
        {{- end }}
    {{- else }}
    {{fail (toYaml $v)  }}
--{{ kebabcase $k }}={{ tpl (toString $v) $ | quote }}
    {{- end }}
{{- end }}
{{- end }}
{{- end }}
